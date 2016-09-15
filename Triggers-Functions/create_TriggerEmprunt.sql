/****************verifier etat compte **********/
CREATE OR REPLACE FUNCTION verifierEtatCompte() RETURNS Trigger AS $$
	DECLARE etat_utilisateur VARCHAR(10);

BEGIN
	SELECT etatabonnement INTO etat_utilisateur
	FROM Utilisateur
	WHERE Utilisateur.idUser = NEW.idUser;
	
	
	IF(etat_utilisateur not LIKE 'normal') THEN
		RAISE NOTICE 'L utilisateur n a pas le droit d emprunter a cause de son etat dabonnement.';
		RETURN NULL;
	ELSE RAISE NOTICE 'Etat utilisauer est normal. OK';
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER t1_verifierEtatCompte
        BEFORE INSERT ON Emprunt 
	FOR EACH ROW
	EXECUTE PROCEDURE verifierEtatCompte();

/* ***************************************************************************** */
/* Un trigger pour vérifier que la nouvelle ligne inseré dans la table emprunt n'éxiste pas déja dans la table
	Exemple: User 10 emprunt l'exemplaire 12 deux fois (avant de le rendre) */
/* Le faite de rendre un document va supprimer sa ligne concercné dans la table Emprunt et en ajoute une nouvelle dans la table Retour (Qui va nous servire comme historique */

CREATE OR REPLACE FUNCTION verifierDuplicationEmprunt() RETURNS TRIGGER AS $$
	DECLARE nb integer;
BEGIN
	SELECT count(*) INTO nb
	FROM Emprunt
	WHERE idUser = NEW.idUser AND idExemplaire = NEW.idExemplaire;
	
	IF (nb = 0) THEN
		RETURN NEW;
	ELSE
		RAISE NOTICE 'User avec ID = % a déjà emprunté un exemplair ID %.', NEW.idUser, NEW.idExemplaire;
		RETURN NULL;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t2_verifierDuplicationEmprunt
	BEFORE INSERT ON Emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE verifierDuplicationEmprunt();

/**************************************************************/

/* verifier la disponibilité d'un exemplaire  */

CREATE OR REPLACE FUNCTION verifier_disponibilite_exemplaire() RETURNS Trigger AS $$
	DECLARE id_exemplaire integer;

BEGIN
	SELECT idexemplaire 
	from emprunt into id_exemplaire 
	where NEW.idexemplaire = emprunt.idexemplaire;
	       
	IF FOUND THEN 
		RAISE NOTICE 'lexemplaire de document (id = % ) est  deja emprunte  ', NEW.idexemplaire;
		RETURN NULL;
	ELSE RAISE NOTICE 'l exempalire est disponible';	
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t3_verifier_disponibilite_exemplaire
	BEFORE  INSERT  ON emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE verifier_disponibilite_exemplaire();
/* ***************************************************************************** */

/* Fonction qui va vérifier le format du document emprunté avec le type d'inscription de l'utlisateur */
/* Récupération du type de l'inscription de l'utilisateur
   Prendre l'idexemplaire pour récupéré l'item et son format
   Vérifier
*/
CREATE OR REPLACE FUNCTION verifierFormatEmprunt() RETURNS Trigger AS $$
	DECLARE typeUser VARCHAR(10);
		formatDoc VARCHAR(20);
BEGIN
	SELECT typeInscription INTO typeUser
	FROM Utilisateur
	WHERE Utilisateur.idUser = NEW.idUser;
	
	SELECT format INTO formatDoc 
	FROM Document
	WHERE Document.idDocument = (SELECT idDocument 
					FROM exemplaire
					WHERE idExemplaire = NEW.idExemplaire);
	RAISE NOTICE 'TypeUser % typeDoc %', typeUser, formatDoc;
	
	IF(typeUser LIKE 'gratuite' and formatDoc not LIKE 'livre') THEN
		RAISE NOTICE 'L utilisateur n a pas le droit d emprunter des CD/DVD.';
		RETURN NULL;
	ELSE IF(typeUSER not LIKE 'cd/dvd' and formatDoc LIKE 'dvd') THEN	
		RAISE NOTICE 'L utilisateur n a pas le droit d emprunter des DVD.';
		RETURN NULL;
	     ELSE 
		RAISE NOTICE 'Format et type abonnement de l utilisateur sont OK';
		RETURN NEW;
	     END IF;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t4_verifierFormatEmprunt
	BEFORE INSERT OR UPDATE ON Emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE verifierFormatEmprunt();
/* ***************************************************************************** */
/* verfier l'age 'adulte , enfant ' est le comaparer avec le  */

CREATE OR REPLACE FUNCTION verifier_age_et_document() RETURNS Trigger AS $$
	DECLARE date_courante DATE;
	        date_naissance DATE;
		age integer;
		categorie_age  VARCHAR(10);
BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	

	select  datenaissance from utilisateur into date_naissance
	where NEW.iduser= utilisateur.iduser;

	SELECT  (date_courante::date - date_naissance::date) / 365  into age;

	select categorie into categorie_age
        from document 
	where iddocument  in (select iddocument
			      from exemplaire
			      where exemplaire.idexemplaire =NEW.idExemplaire);
	IF (categorie_age='adult') and  (age < 18) THEN
		RAISE NOTICE 'ce livre est pour les adultes';
		RETURN NULL;
	ELSE RAISE NOTICE 'Age de l utilisateur OK';
	END IF; 
	 	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t5_verifier_age_et_document
	BEFORE  INSERT  ON emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE verifier_age_et_document();

/* ***************************************************************************** */
/******* verfier la limite de chaque format ***/
CREATE OR REPLACE FUNCTION verifierLimiteFormat() RETURNS Trigger AS $$
	DECLARE myformat VARCHAR(10);
		limit_format INTEGER;
		id_document INTEGER;
   		nb_emprunt_format Integer;

BEGIN
	
	
        SELECT iddocument INTO id_document
	FROM exemplaire
	WHERE exemplaire.idexemplaire = NEW.idexemplaire;  
	
        SELECT format INTO myformat
	FROM document
	WHERE document.iddocument = id_document;

        SELECT limitformat INTO limit_format
	FROM format
	WHERE format.nom = myformat;

        select count(*) into nb_emprunt_format 
	from emprunt
	where emprunt.iduser=NEW.iduser AND emprunt.idexemplaire in (select idexemplaire
								     from exemplaire
								     where exemplaire.iddocument in (select iddocument
 												     from document
												     where document.format= myformat)) ;
	IF (nb_emprunt_format >= limit_format) THEN
	  RAISE NOTICE 'utilisateur n a pas le droit demprunter des documents  (nombre demprunts   >  limit format ) ! ' ;	
	  RETURN NULL;	
	ELSE RAISE NOTICE 'Limit format non atteinte, OK';
	END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER t6_verifierLimiteFormat
        BEFORE INSERT  ON Emprunt 
	FOR EACH ROW
	EXECUTE PROCEDURE verifierLimiteFormat();

/* ***************************************************************************** */


/* Trigger qui vérifie les limites des emprunts DANS UNE BIBLIOTHEQUE: */
/* Fonction: 
	Récupérer la bibliothque, et ses deux limites (LimitDoc et LimitNouveaute)
	Récupérer le nombre de Doc empruntés par l'utilisateur (dans la bib)
	Récupérer le nombre des items nouveautés empruntés par l'utilisateur dans la bibliotheque.

	Insert into emprunt (idUser, idExemplaire, dateEmprunt, dateRetourPrevu)
*/
CREATE OR REPLACE FUNCTION verifierLimitBibliotheque() RETURNS Trigger As $$
	DECLARE idBib integer;
		limitDocument integer;
		limitNew integer;
		nbDocEmprunt integer;
		nbNewEmprunt integer;
		dateCur DATE;
BEGIN

	SELECT dateCourante into dateCur
	FROM DateCourante;

	SELECT idBibliotheque into idBib	
	FROM Exemplaire
	WHERE Exemplaire.idExemplaire = NEW.idExemplaire;
	
	SELECT 	limitdoc into limitDocument
	FROM Bibliotheque
	WHERE bibliotheque.idBibliotheque = idBib;

	SELECT limitNouveaute into limitNew
	FROM Bibliotheque
	WHERE bibliotheque.idBibliotheque = idBib;
	
	DROP TABLE IF EXISTS table_Emprunt_User;
	CREATE TABLE  table_Emprunt_User(idUser, idExemplaire) AS(
		SELECT idUser, idExemplaire
		FROM Emprunt
		WHERE idUser = NEW.idUser );

	SELECT count(*) into nbDocEmprunt
	FROM table_Emprunt_User
	WHERE table_Emprunt_User.idExemplaire IN (SELECT idExemplaire
								FROM Exemplaire
								WHERE Exemplaire.idBibliotheque = idBib
								  AND Exemplaire.idDocument IN (SELECT idDocument 
												FROM Document 
												WHERE Document.Format LIKE 'livre'));
	IF(nbDocEmprunt + 1 > limitDocument) THEN
		RAISE NOTICE 'La limit des emprunts des document dans cette bibliothèque est atteinte pour cet user';
		RETURN NULL;
	ELSE RAISE NOTICE 'Limite d emprunt des docs dans la bibliotheque par l utilisateur --> OK % - %', nbDocEmprunt+1, limitDocument;
	END IF;
	
	SELECT count(*) INTO nbNewEmprunt
	FROM table_Emprunt_User
	WHERE table_Emprunt_User.idExemplaire IN (SELECT idExemplaire
						    FROM Exemplaire
						    WHERE Exemplaire.idBibliotheque = idBib
						     AND Exemplaire.dateAchat > dateCur - '1 month'::interval);

	IF(nbNewEmprunt + 1 > limitNew) THEN
		RAISE NOTICE 'La limit des emprunts des nouveauté dans cette bibliotheque est atteinte pour cet User';
		RETURN NULL;
	ELSE RAISE NOTICE 'Limite d emprunts des nouveaute dans la bibliotheque par l utilisateur --> OK';
	END IF;

	RETURN NEW;
END;
$$LANGUAGE plpgsql;


CREATE TRIGGER t7_VerifierLimitBibliotheque 
	BEFORE INSERT ON Emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE verifierLimitBibliotheque();
/* ***************************************************************************************** */
/* Calcul automatique de la dateemprunt  la table emprunt */

CREATE OR REPLACE FUNCTION insertion_auto_date_emprunt() RETURNS Trigger AS $$
	DECLARE date_courante DATE;

BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	
	NEW.dateemprunt= date_courante;
	RAISE NOTICE 'Generation de la date d emprunt: DateCourante';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t8_insertion_auto_date_emprunt
	BEFORE  INSERT  ON emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE insertion_auto_date_emprunt();
/* ***************************************************************************** */
/* Trigger pour calculer la date de retour prévu automatiquement selon le mois courant (hiver/été) */
/* Récpérer le mois de l'emprunt; depuis la date d'emprunt
   Ajouter 3 semaines si c'est hiver
   Ajouter 6 semaines sinon.
*/
CREATE OR REPLACE FUNCTION calculeDateRetourPrevu() RETURNS TRIGGER AS $$
	DECLARE mois integer;
BEGIN
	SELECT EXTRACT(MONTH FROM NEW.dateEmprunt) INTO mois;
	
	RAISE NOTICE 'mois is %', mois;
	IF(mois < 6 OR mois > 9) THEN
		NEW.dateRetourPrevu = NEW.dateEmprunt  + INTERVAL '3 weeks';
	ELSE NEW.dateRetourPrevu = NEW.dateEmprunt + INTERVAL '6 weeks';
	END IF;
	RAISE NOTICE 'Date retour prevu, calculee selon la saison';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t9_calculeDateRetourPrevu
	BEFORE INSERT ON Emprunt
	FOR EACH ROW
	EXECUTE PROCEDURE calculeDateRetourPrevu();


/* ***************************************************************************** */
/* Trigger pour faire l'opération de renouvellement de l'emprunt. *
	Vérifier Nombre de renouvellement.
	Vérifier Retard.
	Vérifier si le document est reservé.
*/
CREATE OR REPLACE FUNCTION verifier_Renouvelement() RETURNS Trigger AS $$
	DECLARE
		nb_renouvelement INTEGER;
		id_document INTEGER;
   		nb_emprunt_format Integer;
		date_courante DATE;
		date_retour_prevu DATE;
BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	
        SELECT nbrenouvellement INTO nb_renouvelement
	FROM emprunt
	WHERE emprunt.iduser=NEW.iduser;


        SELECT dateretourprevu INTO date_retour_prevu
	FROM emprunt
	WHERE emprunt.iduser=NEW.iduser;

        IF NOT ((nb_renouvelement<=2) AND (date_retour_prevu > date_courante)) THEN
		 RAISE NOTICE 'Document en retard ou nombre de renouvelement atteint';
		 RETURN NULL;
	ELSE RAISE NOTICE 'Document n est pas en retard. nombre de renouvellement < 2...OK';
	END IF;

	PERFORM idReservation
	FROM Reservation
	WHERE Reservation.idDocument = (SELECT IdDocument FROM Exemplaire WHERE Exemplaire.idExemplaire = NEW.idExemplaire)
	AND Reservation.idBibliotheque = (SELECT IdBibliotheque FROM Exemplaire WHERE Exemplaire.idExemplaire = NEW.idExemplaire);
	
	IF FOUND THEN
		RAISE NOTICE 'Ce document est reserve, vous ne pouvez pas renouveller.';
		RETURN NULL;
	ELSE RAISE NOTICE 'Document non reserve. OK';
	
		
	END IF; 
	
	NEW.DateRetourPrevu = NEW.DateRetourPrevu + INTERVAL '3 weeks';
	NEW.nbRenouvellement = OLD.nbRenouvellement +1;
	RAISE NOTICE 'Mise a jour des dates et nombre de renouvellement';
	RETURN NEW;
	       	
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER t2_verifier_Renouvelement
        BEFORE UPDATE OF nbRenouvellement ON Emprunt 
	FOR EACH ROW
	EXECUTE PROCEDURE verifier_Renouvelement();



