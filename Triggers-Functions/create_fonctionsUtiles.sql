/* Fonction qui vérifie si un utilisateur a des document en retard ou pas */
CREATE OR REPLACE FUNCTION verifierRetard(idUtilisateur integer) RETURNS BOOLEAN AS $$
	DECLARE id integer;
		courante Date;
BEGIN
	SELECT dateCourante INTO courante
	FROM DateCourante;
	
	SELECT idEmprunt INTO id
	FROM Emprunt
	WHERE Emprunt.dateRetourPrevu < courante 
		AND Emprunt.idUser = idUtilisateur;
	
	IF NOT FOUND THEN
		RETURN FALSE;
	ELSE RETURN TRUE;
	END IF;
END;
$$ LANGUAGE plpgsql;
/*********************************************************************************/
/* Fonction pour faire la recheche des livres: */
CREATE OR REPLACE FUNCTION rechercherLivre(motCle varchar(30), idbib integer) RETURNS
	TABLE (titre VARCHAR(200),
		bibliotheque VARCHAR(100),
		nbExemplaire integer,
		disponible VARCHAR(50))
AS $$
	DECLARE d document%rowtype;
		b Bibliotheque%rowtype;
		c integer;
		e VARCHAR(50);
		cEmprunt integer;
		idRes integer;
BEGIN
	motCle = '%'||motcle||'%';
	
	DROP TABLE IF EXISTS resultatRecherche CASCADE;
	CREATE TEMP TABLE resultatRecherche(
		titre VARCHAR(200),
		bibliotheque VARCHAR(100),
		nbExemplaire integer DEFAULT 0,
		disponible VARCHAR(50));

	RAISE NOTICE 'Resultat de la recherche pour %', motCle;
	FOR d IN SELECT * FROM Document 
	WHERE Document.titre LIKE motCle 
	OR Document.idAuteur IN (SELECT idAuteur FROM Auteur WHERE Auteur.nom LIKE motCle OR Auteur.prenom LIKE motCle)
	LOOP
		FOR b IN SELECT * FROM Bibliotheque WHERE (idbibliotheque = idbib AND idbib > 0) OR (idbib = 0 AND idbibliotheque > 0)
		LOOP 
			SELECT count(*) INTO c
			FROM Exemplaire
			WHERE Exemplaire.idDocument = d.idDocument AND Exemplaire.idBibliotheque = b.idBibliotheque;
			
			IF c = 0 THEN 
				e = 'Inexistant';
			ELSE 
				SELECT idReservation into idRes
				FROM Reservation
				WHERE Reservation.idDocument = d.idDocument AND Reservation.idBibliotheque = b.idBibliotheque;
				IF FOUND THEN
					e = 'Reserve';
				ELSE
					SELECT count(*) INTO cEmprunt
					FROM Emprunt
					WHERE Emprunt.idExemplaire IN 
							(SELECT idExemplaire FROM Exemplaire WHERE Exemplaire.idDocument = d.idDocument);
					IF cEmprunt = c THEN
						e = 'Emprunte, non disponible';
					ELSE e = 'disponible';
					END IF;
				END IF;
			END IF;
			INSERT INTO resultatRecherche VALUES (d.titre, b.nom, c, e);
		END LOOP;	
	END LOOP;
	RAISE NOTICE 'Fin resultat';
	RETURN QUERY SELECT * FROM resultatRecherche;
	
END;
$$ LANGUAGE plpgsql;

/*********************************************************************************/

/* supprimer_les_donnes_trop_vieux */
CREATE OR REPLACE FUNCTION supprimer_les_donnes_trop_vieux()  RETURNS VARCHAR AS $$
	DECLARE date_courante DATE;
BEGIN
       select datecourante from datecourante into date_courante;
	
	delete from retour
	where (date_courante::date - retour.dateretour::date)> 60 and iduser not in ( select iduser
										     from utilisateur
										     where utilisateur.penalite >0)  ;
	RETURN 'Success';

END;
$$ LANGUAGE plpgsql;


/*********************************************************************************/

/* renouvler l'inscription */
CREATE OR REPLACE FUNCTION renouvler_inscription_utilisateur(iduser_param integer)  RETURNS VARCHAR AS $$
	DECLARE date_courante DATE;
			date_expiration date;		
	jour_avant_expiration integer;
	penalite_user integer;
	retard boolean;
BEGIN
             select penalite into penalite_user 
	     from utilisateur	
	     where utilisateur.iduser = iduser_param;

		select dateexpiration into date_expiration
		from utilisateur
		where idUser = idUser_param;
	     if	(penalite_user >= 0 and penalite_user< 15 ) then 
			      
                 select datecourante from datecourante into date_courante;
		 if (date_expiration > date_courante) then
		
			 select (utilisateur.dateexpiration::date - date_courante::date) 
                	 into jour_avant_expiration
	 		 where utilisateur.iduser = iduser_param; 
		else 
			jour_avant_expiration:=29;
		end if ;
	
		if (jour_avant_expiration > 30) then 
			RAISE NOTICE 'pour renouvler labonnement il faut faire cette operation un mois avant lexperation de votre abonnement ';	
			return 'Fail';		
		 end if;

		     select verifierRetard(iduser_param) into retard;  
			if (retard =true) then 
				update  utilisateur set etatabonnement = 'suspendu'
				 where utilisateur.iduser= iduser_param;         

			else 
				update  utilisateur set etatabonnement = 'normal'
				 where utilisateur.iduser= iduser_param;         
			end if; 		

		 update  utilisateur set dateexpiration = date_courante + '1 year'::interval
		 where utilisateur.iduser= iduser_param;         
		RETURN 'Success';  
	    else 

			RAISE NOTICE 'la penalité de l utilisateur a depassee 15 euro , pas de renouvellement.';	
			return 'fail';		 	
	    end if;
END;
$$ LANGUAGE plpgsql;

/****************************************************************************************************/
/*	pourcentage de livres en cours d’emprunt dans chaque bibliothèque 
	Nombre d'exemplaire dans une bibliotheque / nombre d'emprunt * 100 */
CREATE OR REPLACE FUNCTION pourcentageEmprunt (idBib integer) RETURNS decimal AS $$
	DECLARE nbExemplaire decimal;
		nbEmprunt decimal;
BEGIN
	SELECT count(*) INTO nbExemplaire
	FROM Exemplaire
	WHERE Exemplaire.idBibliotheque = idBib;
	RAISE NOTICE 'nb Exemplaire dans cette bibliotheque est: %', nbExemplaire;

	SELECT count(*) INTO nbEmprunt
	FROM Emprunt
	WHERE Emprunt.idExemplaire IN (SELECT idExemplaire FROM Exemplaire WHERE idBibliotheque = idBib);
	RAISE NOTICE 'nb Emprunt dans cette bibliotheque est: %', nbEmprunt;

	RAISE NOTICE 'Pourcentage d emprunt dans cette bibliotheque: % pourcent', (nbEmprunt/nbExemplaire)*100.0;
	RETURN (nbEmprunt/nbExemplaire)*100.0;
END;
$$ LANGUAGE plpgsql;
/* Meme fonction, pour toutes les bibliothèques: */
CREATE OR REPLACE FUNCTION pourcentageEmprunt() RETURNS
	TABLE (idbibliotheque integer,
		pourcentage decimal)
 AS $$
	DECLARE b bibliotheque%rowtype; 
		nbExemplaire decimal;
		nbEmprunt decimal;
BEGIN
	DROP TABLE IF EXISTS resultatPourcentage CASCADE;
	CREATE TEMP TABLE resultatPourcentage(
		idbibliotheque integer,
		pourcentage decimal);


	FOR b IN SELECT * FROM Bibliotheque LOOP
		SELECT count(*) INTO nbExemplaire
		FROM Exemplaire
		WHERE Exemplaire.idBibliotheque = b.idBibliotheque;
		
		SELECT count(*) INTO nbEmprunt
		FROM Emprunt
		WHERE Emprunt.idExemplaire IN (SELECT idExemplaire FROM Exemplaire WHERE Exemplaire.idBibliotheque = b.idBibliotheque);
	
		INSERT INTO resultatPourcentage VALUES (b.idBibliotheque, (nbEmprunt/nbExemplaire)*100);
	END LOOP;
	RETURN QUERY SELECT * FROM resultatPourcentage;
END;
$$ LANGUAGE plpgsql;

/****************************************************************************************************/
/* Nombre de retard dans une bibliotheque: */
CREATE OR REPLACE FUNCTION nbRetard(idBib INTEGER) RETURNS INTEGER AS $$
	DECLARE nbRetard INTEGER;
		date_courante DATE;
BEGIN
	SELECT dateCourante INTO date_courante FROM DateCourante;

	SELECT count(*) INTO nbRetard
	FROM Emprunt
	WHERE Emprunt.dateRetourPrevu < date_courante;
	
	RETURN nbRetard;
END;
$$ LANGUAGE plpgsql;

/****************************************************************/
/* nombre d'emprunt de mois dernier */
CREATE OR REPLACE FUNCTION nombre_emmprunt_de_mois_dernier_rendu_nonrendu(id_bibliotheque integer)  RETURNS VARCHAR AS $$
	DECLARE date_courante DATE;
		resultat_emprunt_rendu integer;
		resultat_emprunt_non_rendu integer;
		nom_bib varchar(100);

BEGIN
       	select datecourante from datecourante into date_courante;
	
	select count (*) into resultat_emprunt_non_rendu	
        from emprunt
	where (date_courante::date - emprunt.dateemprunt::date) <=30  and idexemplaire in (select idexemplaire
											   from exemplaire 			
											   where  exemplaire.idbibliotheque= id_bibliotheque);

	
	select count (*) into resultat_emprunt_rendu	
        from retour
	where (date_courante::date - retour.dateemprunt::date) <=30 and idexemplaire in (select idexemplaire
											 from exemplaire 			
											  where  exemplaire.idbibliotheque= id_bibliotheque);
 
	select nom into nom_bib
	from bibliotheque
	where bibliotheque.idbibliotheque=id_bibliotheque; 	
	RAISE NOTICE 'Nombre demprunts dans labibliiotheque %  (rendu : -->  % ) /(non rendu : --> %) ',nom_bib,resultat_emprunt_rendu,resultat_emprunt_non_rendu;
	RETURN 'Success';

END;
$$ LANGUAGE plpgsql;
/**************************************************************************/
/* Fonction pour renouvelleer un pret */
CREATE OR REPLACE FUNCTION renouveler(idUsr integer, idExp integer) RETURNS void AS $$
	DECLARE idEmpt integer;
BEGIN
	SELECT idEmprunt INTO idEmpt
	FROM Emprunt
	WHERE idUser = idUsr AND idExemplaire = idExp;
	IF NOT FOUND THEN
		RAISE NOTICE 'Aucun pret pour cet utilisateur et cet exemplaire';
	ELSE
		UPDATE Emprunt
		SET nbRenouvellement = nbRenouvellement +1
		WHERE Emprunt.idEmprunt = idEmpt;
	
	END IF;
END;
$$ LANGUAGE plpgsql;
