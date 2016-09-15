/* 	
	DateCourante pour ce test: 2016-04-25 */
/* Scenario: 
	Faire un retour sans erreur et faire un select pour voir la générations des dates (dateRetour et DateEmprunt)
	Et la suppression de la ligne correspondante depuis la table emprunt:
	On fait un pret d'abord... */
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 1);
INSERT INTO Retour (idUser, idExemplaire) VALUES (1, 1);
SELECT * FROM Retour WHERE idUser = 1 AND idExemplaire = 1;
SELECT * FROM Emprunt WHERE idUser = 1 AND idExemplaire = 1;

/* *********************************************************************/
/* Scenario:
	Rendre un document en retard. Tester les deux cas possibles:
		- L'utilisateur ait un autre document en retard, son etat reste toujours Suspendu
		- L'utilisateur n'a pas d'autres document en retard, son etat devient Normal (Si la penalité n'est pas > 15).
*/
/* 1er cas: */
update dateCourante set dateCourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 1);
/* modifier la date courante, pour inserer un nouvel emprunt de l'utilisateur)*/
UPDATE DateCourante set DateCourante = '2016-05-03';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 2);
/* Modifier la date courante pour créer le retard pour le premier emprunt (mais pas pour le deuxieme): */
UPDATE DateCourante set DateCourante = '2016-05-19';
/* Voir etat de l'utilisateur, rendre le 1er doc, et vérifier*/
select idUser, penalite, etatabonnement FROM utilisateur WHERE idUser = 1;
INSERT INTO Retour (idUser, idExemplaire) VALUES (1, 1);
SELECT idUser, penalite, etatabonnement FROM utilisateur WHERE idUser = 1;

/* 2eme cas: Ajouter un deuxieme pret, rendre tt les prets en retard, retourner 1 pret, verifier User*/
update dateCourante set datecourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 3);
update dateCourante set dateCourante = '2016-06-10';
SELECT idUser, penalite, etatabonnement FROM utilisateur WHERE idUser = 1;
INSERT INTO Retour (idUser, idExemplaire) VALUES (1, 2);
SELECT idUser, penalite, etatAbonnement FROM Utilisateur WHERE idUser = 1;
/* L'utilisateur reste suspendu, car il a encore un autre document en retard.*/

/* ************************************************************************************************************* */
/* Scenarion:
	Rendre un document qui est déja reservé par un autre utilisateur dans la meme bibliotheque.
	Document choisi: 2 
	Bibliotheque: 3 (doc 2 a 2 exemplaire (19 ET 20) dans cette bibliotheque)
	Utilisateur Rendant le document: 1
	Utilisatuer faisant la reservation: 2
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 2, 3, '2016-07-29');
INSERT INTO Retour (idUser, idExemplaire) VALUES (1, 19);/* Voir le message indiquant que le document est reservé !!*/
/* Supprimer la reservation, rendre l'autre document; pour voir que le message n'apparaissera pas */
DELETE FROM Reservation where idUser = 2 AND idDocument = 2 AND idBibliotheque = 3;
INSERT INTO Retour (idUser, idExemplaire) VALUES (1, 20);/* Ce document n'est pas reservé */

/******************************************************************************************************************** */

