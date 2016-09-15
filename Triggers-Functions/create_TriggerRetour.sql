/* Calcul automatique de la date de retour et la date d'emprunt:*/
CREATE OR REPLACE FUNCTION insertion_auto_date_retour() RETURNS Trigger AS $$
	DECLARE date_courante DATE;
		date_emprunt DATE;

BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	
	NEW.dateretour= date_courante;
	SELECT dateEmprunt INTO date_emprunt
	FROM Emprunt
	WHERE Emprunt.idUser = NEW.idUser AND Emprunt.idExemplaire = NEW.idExemplaire;
	NEW.dateEmprunt = date_emprunt;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t0_insertion_auto_date_retour
	BEFORE  INSERT  ON retour
	FOR EACH ROW
	EXECUTE PROCEDURE insertion_auto_date_retour();
/* ***************************************************************************** */

/* Trigger pour vérifier la date de retour du document avec la date de retour prevu, et calculer la penalité */
/*
	Récupérer la ligne de l'emprunt corréspondant
	Récupérer la date de retour prévu
	Récupérer la date courante
	Faire la différence et calculer la pénalité et mettre aà jour la table Utilisateur
	Bloquer l'utilisateur si sa pénalité dépasse les 15€
*/
/*
CREATE OR REPLACE FUNCTION verifierDateRetour() RETURNS TRIGGER AS $$
	DECLARE datePrevu DATE;
		difference integer;
		newPenalite decimal;
BEGIN
	SELECT dateRetourPrevu INTO datePrevu
	FROM Emprunt
	WHERE idUser = NEW.idUser AND idExemplaire = NEW.idExemplaire;

	SELECT NEW.dateRetour::date - datePrevu::date INTO difference;

	RAISE NOTICE 'Difference between % and % is  %', datePrevu, NEW.dateRetour, difference;
	IF(difference > 0) THEN
		UPDATE Utilisateur 
		SET Penalite = Penalite + (difference * 0.15)
		WHERE idUser = NEW.idUser;
		
		SELECT penalite into newPenalite
		FROM Utilisateur 
		WHERE idUser = NEW.idUser;
		
		RAISE NOTICE 'Id movifier: %', NEW.idUser;
		
		IF(newPenalite >= 15) THEN
			RAISE NOTICE 'Limit des penalites atteinte pour cet utilisateur. Il sera bloqué.';
			UPDATE Utilisateur
			SET EtatAbonnement = 'bloque'
			WHERE idUser = NEW.idUser;
			
			RAISE NOTICE 'Utilisateur % bloqué.', NEW.idUser;
		END IF;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* Trigger associé: 
CREATE TRIGGER t1_verifierDateRetour
	BEFORE INSERT ON Retour
	FOR EACH ROW
	EXECUTE PROCEDURE verifierDateRetour();
*/
/**********************************************************************/
/* Fonction qui va supprimer le  document emprunté from table emprunt apres l'insertion dans la table de retour 
	Et qui vérifie que l'emprunt a eu lieu.
*/
CREATE OR REPLACE FUNCTION delete_emprunt_after_retour() RETURNS Trigger AS $$
	DECLARE iduser_TMP integer;

BEGIN

	SELECT iduser into iduser_TMP
	FROM emprunt 
	WHERE NEW .idUser = emprunt.idUser AND NEW.idexemplaire= emprunt.idexemplaire ;
	
	if not FOUND 	then
		RAISE NOTICE 'document nexiste pas : utilsateur = % n a pas emprunte le document = %', NEW.iduser, NEW.idexemplaire ;
		RETURN null;	
	END IF;	
	
	DELETE  from emprunt 

	WHERE NEW .idUser = emprunt.idUser AND NEW.idexemplaire= emprunt.idexemplaire ;
	RAISE NOTICE 'Emprunt associe a ce retour vient d etre supprime. OK';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t2_delete_emprunt_after_retour
	BEFORE  INSERT  ON retour
	FOR EACH ROW
	EXECUTE PROCEDURE delete_emprunt_after_retour();

/* ***************************************************************************** */

/* Trigger qui vérifie l'état de l'utilisateur après le retour de son document
	Verifier s'il lui reste des documents toujours en retard
*/

CREATE OR REPLACE FUNCTION updateEtatUserAfterRetour() RETURNS TRIGGER AS $$
	DECLARE retard boolean;
BEGIN
	SELECT verifierRetard(NEW.idUser) INTO retard;
	RAISE NOTICE 'Est ce que l utilisateur a d autres retards? %', retard;
	IF(retard) THEN
		UPDATE Utilisateur 
		Set EtatAbonnement = 'suspendu'
		WHERE idUser = NEW.idUser;
		RAISE NOTICE 'l utilisateur a toujours des docs en retard. Il reste Suspendu';
	ELSE 
		UPDATE Utilisateur
		SET EtatAbonnement = 'normal'
		WHERE idUser = NEW.idUser;
		RAISE NOTICE 'Les prets de l utilisateurs sont tous OK. Etat = Normal';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t3_updateEtatUserAfterRetour
	AFTER INSERT ON Retour
	FOR EACH ROW
	EXECUTE PROCEDURE updateEtatUserAfterRetour();
/**************************************************************************/

/* Trigger qui notifie si l'article rendu est reservé: */
CREATE OR REPLACE FUNCTION notifierRetourReserve() RETURNS TRIGGER AS $$
	DECLARE idDoc integer;
		 idBib integer;
		 idRes integer;
BEGIN
	SELECT idDocument INTO idDoc
	FROM Exemplaire
	WHERE Exemplaire.idExemplaire = NEW.idExemplaire;
	
	SELECT idBibliotheque INTO idBib
	FROM Exemplaire
	WHERE Exemplaire.idExemplaire = NEW.idExemplaire;

	SELECT idReservation into idRes
	FROM Reservation
	WHERE Reservation.idDocument = idDoc 
	 AND Reservation.idBibliotheque = idBib;
	
	IF FOUND THEN
		RAISE NOTICE 'NOTE: Ce document est reserve. ID Reservation = %', idRes;
	ELSE
		RAISE NOTICE 'Ce document n est pas reserve.';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t4_notifierRetourReserve
	AFTER INSERT ON Retour
	FOR EACH ROW
	EXECUTE PROCEDURE notifierRetourReserve();

