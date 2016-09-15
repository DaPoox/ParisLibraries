/*
	Création des triggers
	DATE COURANTE = 26-04-25
*/

/* Trigger de vérification de la cohérence des dates dans la tables utilisateur */ 
CREATE OR REPLACE FUNCTION chekdate() RETURNS Trigger AS $$
	DECLARE date_courante DATE;
BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	IF (NEW.dateNaissance > date_courante)   THEN
     	  RAISE NOTICE 'date de naissance est supérieure à la date courante.';
     	  RETURN NULL;
	END IF;
	RAISE NOTICE 'Date Naissance Ok';

RETURN NEW;

END;
$$ LANGUAGE plpgsql;

/* Trigger associé à la fonction de vérification des dates dans la table utilisateur: */
DROP TRIGGER t1_chek_date_user ON Utilisateur;
CREATE TRIGGER  t1_chek_date_user
	BEFORE INSERT ON Utilisateur
	FOR EACH ROW
	EXECUTE PROCEDURE chekdate();
/* ******************************************************************************** */
/*** trigger pour regler l'etat d'abonnment   apres le paiment de la penalité**/
CREATE OR REPLACE FUNCTION payer_penalite_abonnement() RETURNS Trigger AS $$
  DECLARE  retard boolean; 
BEGIN
      IF (NEW.penalite =0) THEN		
	     	SELECT verifierRetard (NEW.iduser) into retard;
	      	IF (retard = true) then
	 	     UPDATE utilisateur SET etatabonnement ='suspendu' 
			WHERE iduser= NEW.iduser AND NEW.dateExpiration > (SELECT dateCourante FROM dateCourante);
			RAISE NOTICE 'Utilisateur mis a jours %.', NEW.idUser;
		     RETURN NEW;      
	      	ELSE 
		     UPDATE utilisateur SET etatabonnement ='normal' 
			WHERE iduser= NEW.iduser AND NEW.dateExpiration > (SELECT dateCourante FROM dateCourante);
			RAISE NOTICE 'Utilisateur mis a jours %.', NEW.idUser;
		     RETURN NEW;      
	      	END IF; 
     END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER  t1_payer_penalite_abonnement
	AFTER  UPDATE of penalite ON utilisateur
	FOR EACH ROW
	EXECUTE PROCEDURE payer_penalite_abonnement();
/* ******************************************************************************** */
/* Initialisation des attributs d'un user: 
	- Date Inscrption = Date Courante
	- Date exepiration = Date courante +1 an
	- Etat abonnement = Normal 
*/
CREATE OR REPLACE FUNCTION initUser() RETURNS TRIGGER AS $$
BEGIN
	SELECT dateCourante INTO NEW.dateInscription 
	FROM DateCourante;
	NEW.dateExpiration = NEW.dateInscription + INTERVAL '1 year';
	NEW.etatAbonnement = 'normal';
	RAISE NOTICE 'Initialisation du user effectue (dateCourante, dateExpiration, etatAbonnement)';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t2_initUser
	BEFORE INSERT ON Utilisateur
	FOR EACH ROW
	EXECUTE PROCEDURE initUser();


