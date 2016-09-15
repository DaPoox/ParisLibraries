/* Liste des triggers de la table Reservation */

/* Fontion de verification de la date reservée avec la date courante */
CREATE OR REPLACE FUNCTION chek_date_resrvation() RETURNS Trigger AS $$
	DECLARE date_courante DATE;
BEGIN
	SELECT dateCourante from DateCourante into date_courante; 
  	IF (NEW.dateReserve IS NULL) OR
  	    (NEW.dateReserve < date_courante) 
   	THEN
   	    RAISE NOTICE 'La date reserve est inferieure à la date courante';
   	    RETURN NULL;
	END IF;
	RAISE NOTICE 'Date reserve OK';
  	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*Trigger associé à la fonction check chek_date_resrvation() */
CREATE TRIGGER  t0_check_date_reservation
	BEFORE INSERT OR UPDATE ON Reservation
	FOR EACH ROW
	EXECUTE PROCEDURE chek_date_resrvation();


/*****************************************************************/
/*  trigger pour voir si le document est deja reservé par le meme user
*/
CREATE OR REPLACE FUNCTION chek_deja_reserve () RETURNS Trigger AS $$
	DECLARE  tmp INTEGER;
BEGIN
        select idreservation into tmp
	from Reservation
	where Reservation.iduser=NEW.iduser and Reservation.iddocument= NEW.iddocument and Reservation.idbibliotheque= NEW.idbibliotheque;
       
	IF FOUND THEN 
		RAISE NOTICE 'document deja reservé par Utilsateur = %, il na pas le droit de reserver le meme document plusieurs fois!!!  ', NEW.iduser;
	RETURN NULL;	
	END IF;
	RAISE NOTICE 'Le document n est pas reserve par le meme user... OK';
   
RETURN NEW;

END;
$$ LANGUAGE plpgsql;

/*Trigger associé à la fonction check chek_date_resrvation() */
CREATE TRIGGER  t1_check_deja_reserve
	BEFORE INSERT  ON Reservation
	FOR EACH ROW
	EXECUTE PROCEDURE chek_deja_reserve();
/***********************************************************************************/

/* nombre de reservation <=5*/
CREATE OR REPLACE FUNCTION chek_nombre_de_reservation () RETURNS Trigger AS $$
	DECLARE  limitreservation INTEGER;
BEGIN
        select count(*) into limitreservation
	from Reservation
	where Reservation.iduser=NEW.iduser;
       
	IF (limitreservation>= 5) THEN 
		RAISE NOTICE 'Utilsateur = % na pas le droit de reserver  le document , il a depassé la limite de reservation !!!', NEW.iduser;
	RETURN NULL;	
	END IF;
   	RAISE NOTICE 'Nombre de reservation de cet utilisateur est OK';
RETURN NEW;

END;
$$ LANGUAGE plpgsql;

/*Trigger associé à la fonction check chek_nombre_resrvation() */
CREATE TRIGGER  t2_check_nombre_de_reservation
	BEFORE INSERT  ON Reservation
	FOR EACH ROW
	EXECUTE PROCEDURE chek_nombre_de_reservation();

/*******************************************************************************/
/*	Vérifier que l'utilisateur qui reserve n'a pas de document en retard. 
	En utilisant la fonction qu'on a créé: VerifierRetard():
*/
CREATE OR REPLACE FUNCTION verifierRetardBeforeReservation() RETURNS TRIGGER AS $$
	DECLARE retard boolean;
BEGIN
	SELECT verifierRetard(NEW.idUser) into retard;
	IF(retard) THEN
		RAISE NOTICE 'L utilisater a un document en retard. Reservation refusee';
		RETURN NULL;
	ELSE 
		RAISE NOTICE 'L utilisateur n a pas de document en retard. OK';		
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t3_verifierRetardBeforeReservation
	BEFORE INSERT ON Reservation
	FOR EACH ROW
	EXECUTE PROCEDURE verifierRetardBeforeReservation();

/****************************************************************************/

/* Vérifier si le document est disponible dans la bibliothèque avant d'effectuer la reservation: 
	Parcourir la table emprunt et voir s'il existe un exemplaire disponible
	Si ce n'est pas le cas, annulé la reservation
	Sinon, autoriser la reservation
*/
CREATE OR REPLACE FUNCTION verifierDisponibiliteBeforeReservation() RETURNS TRIGGER AS $$
	DECLARE exemplaireDispo integer;
BEGIN
	SELECT idExemplaire INTO exemplaireDispo
	FROM Exemplaire
	WHERE Exemplaire.idBibliotheque = NEW.idBibliotheque
	 AND Exemplaire.idDocument = NEW.idDocument
	 AND Exemplaire.idExemplaire NOT IN (SELECT idExemplaire
						FROM Emprunt);
	IF NOT FOUND THEN
		RAISE NOTICE 'Il n existe pas d exemplaire disponible.... OK';
		RETURN NEW;
	ELSE
		RAISE NOTICE 'Il exist un exemplaire disponible %', exemplaireDispo;
		RETURN NULL;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t4_verifierDisponibiliteBeforeReservation 
	BEFORE INSERT ON Reservation
	FOR EACH ROW
	EXECUTE PROCEDURE verifierDisponibiliteBeforeReservation();

/*************************************************************/
/* Inserer la date de reservation (le jours où on a effectuer la reservation) **/
CREATE OR REPLACE FUNCTION insertion_auto_date_reservation() RETURNS Trigger AS $$
	DECLARE date_courante DATE;

BEGIN
	SELECT dateCourante from DateCourante into date_courante;
	
	 NEW.datereservation= date_courante;
	RAISE NOTICE 'Date de la reservation => DateCourante OK';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t5_insertion_auto_date_reservation
	BEFORE  INSERT  ON reservation
	FOR EACH ROW
	EXECUTE PROCEDURE insertion_auto_date_reservation();

