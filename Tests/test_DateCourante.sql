
/*****Ajouter des reservation et modifier la date courante en la mettant = date d'un des documents reservés. Voir la notice.***/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 2, 3, '2016-07-29');

update datecourante set datecourante='2016-07-29';

INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(3, 2, 3, '2016-07-29');

/*****Modifier la date courante de tel sorte que des utilisateur deviennent bloqué (abonnement expiré) ;***/
select iduser,etatabonnement from utilistaeur;
update datecourante set datecourante ='2016-05-15';
select iduser,etatabonnement from utilistaeur;

/* iduser = 12 devient bloqué
*/

/***********
Modifier dateCourante pour que les prets less then 2 days seront affiché (mettres des prets de 2 jours restants, 1 journée restantes et 0 jours restants)***************/

INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);

update datecourante set datecourante='2016-05-14';

update datecourante set datecourante='2016-04-25';


/**Afficher la listes des utilisateurs avec leurs id, penalites et etatAbonnement pour voir le changement (Assurer d'avoir tt les cas possibles (penalité < 15, penalité >15).
*/


INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);

select iduser, penalite, etatabonnement, dateexpiration from utilisateur; 
/***suspendu <15****/
update datecourante set datecourante='2016-05-20';
select iduser, penalite, etatabonnement, dateexpiration from utilisateur; 

/*****bloque > 15***/
update datecourante set datecourante='2016-08-20';
select iduser, penalite, etatabonnement, dateexpiration from utilisateur; 

update datecourante set datecourante='2016-04-25';

