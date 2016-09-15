/* Trigger pour signaler les reservation pour aujourd'hui */
/*
	Parcourir les reservation
	Si la reservation est pour aujourd'hui; afficher un message.
*/
CREATE OR REPLACE FUNCTION notifierReservation() RETURNS TRIGGER AS $$
	DECLARE r Reservation%rowtype;
BEGIN
	RAISE NOTICE 'Verification des reservation: ';
	FOR r IN SELECT * FROM Reservation WHERE dateReserve = NEW.dateCourante LOOP
		RAISE NOTICE 'Reservation pour aujourd hui: User % Document % Bibliotheque %', r.idUser, r.idDocument, r.idBibliotheque;
	END LOOP;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t1_notifierReservation 
	AFTER UPDATE ON DateCourante
	FOR EACH ROW
	EXECUTE PROCEDURE notifierReservation();


/* ******************************************************************************** */

/*** trigger pour modifier l'etat d'abonnement apres le changement de la date**/
CREATE OR REPLACE FUNCTION verifier_expiration() RETURNS Trigger AS $$
BEGIN

    	UPDATE utilisateur
		SET etatabonnement = 'bloque'
	WHERE (dateExpiration <= NEW.dateCourante) ;
	RAISE NOTICE 'Les utilisateurs dont leur abonnement est expire sont maintenant bloque';
 RETURN NEW;
   END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER  t1_verifier_expiration
	AFTER  UPDATE ON datecourante
	FOR EACH ROW
	EXECUTE PROCEDURE verifier_expiration();
/* ************************************** ***************************************** */
/* Trigger pour afficher alert des emprunt -2 jours */
CREATE OR REPLACE FUNCTION afficher_alert_emprunt() RETURNS Trigger AS $$

DECLARE 	r emprunt%rowtype;
		 datecourante date;
		difference integer;	
BEGIN
    RAISE NOTICE 'Voir si on a des emprunts qui leurs reste moins de deux jours';
    FOR r IN SELECT * from emprunt LOOP	
  	  SELECT  r.dateretourprevu::date - new.datecourante::date INTO difference;			      
		if (difference <= 2) and (difference >= 0 )then  	       
			RAISE NOTICE 'utilisateur % n a que  % jours pour rendre l exemplaire = % ' ,r.iduser, difference, r.idexemplaire;
	        end if;
    END LOOP;


RETURN NEW;
 END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER  t1_afficher_alert_emprunt
	AFTER  UPDATE ON datecourante
	FOR EACH ROW
	EXECUTE PROCEDURE afficher_alert_emprunt();

/************************************************************************************
/* Trigger pour mettre à jours les pénalités et l'état de chaque utilisateur selon la liste des emprunts: 
	Si l'emprunt était déjà en retard avant la mise à jours de la date, penalite = penalite + dif entre old date et new date * 0.15
	sinon, ça veut dire que l'emprunt vient tout juste de dépasser la date de retour prevu, d
	donc dans ce cas, penalite = penalite + dif entre New date et Date retour prevu * 0.15
**/
CREATE OR REPLACE FUNCTION updateUserState() RETURNS TRIGGER AS $$
	DECLARE penaliteTmp decimal;
		r Emprunt%rowtype;
		difference integer;
		pen decimal;
BEGIN

	IF OLD.dateCourante > NEW.dateCourante THEN
		UPDATE Utilisateur 
		SET etatAbonnement = 'normal'
		WHERE (Utilisateur.dateExpiration > NEW.dateCourante AND NOT verifierRetard(Utilisateur.idUser) AND Utilisateur.penalite < 15);
		
		UPDATE Utilisateur 
		SET EtatAbonnement = 'suspendu'
		WHERE (Utilisateur.dateExpiration > NEW.dateCourante AND verifierRetard(Utilisateur.idUSer) AND Utilisateur.penalite < 15); 
	ELSE 	
		RAISE NOTICE 'Mise a jours des penalites et etat des utilisateurs: ';
		FOR r IN SELECT * from Emprunt WHERE dateRetourPrevu < NEW.dateCourante LOOP	
			IF r.dateRetourPrevu < OLD.dateCourante THEN
				SELECT NEW.dateCourante::date - OLD.dateCourante::date INTO difference;
			ELSE IF NEW.dateCourante > OLD.dateCourante THEN		
				SELECT NEW.dateCourante::date - r.dateRetourPrevu::date INTO difference;
			     END IF;
			END IF;
			RAISE NOTICE 'Difference = %',difference;
		
			UPDATE Utilisateur 
			SET penalite = penalite + (difference * 0.15)
			WHERE Utilisateur.idUser = r.idUser;
			
			SELECT penalite into pen
			FROM Utilisateur
			WHERE idUser = r.idUser;
	
			IF(pen >= 15) THEN
				UPDATE Utilisateur
				SET etatAbonnement = 'bloque'
				WHERE Utilisateur.idUser = r.idUser;
				RAISE NOTICE 'La somme des penalites pour l utilisateur %s est superieur a 15EUR = % EUR', r.idUser, pen;
			ELSE
				UPDATE Utilisateur
				SET etatAbonnement = 'suspendu'
				WHERE Utilisateur.idUser = r.idUser;
			END IF;
		END LOOP;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  t1_updateUserState
	AFTER  UPDATE ON datecourante
	FOR EACH ROW
	EXECUTE PROCEDURE updateUserState();

