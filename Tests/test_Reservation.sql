/* 	
	DateCourante pour ce test: 2016-04-25 */
/* Scénario: 
	Faire une reservation pour une date < dateCourante
*/
update dateCourante set datecourante = '2016-04-25';
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(1, 1, 1, '2011-01-15');
/* Scénario:
	Reserver 2 fois le meme document dans la meme bibliotheque
	Document: 2
	Bibliotheque: 3 (exemplaire 19, 20)
	Tous les exemplaire doivent etres emprunté pour qu'on puisse effectuer la reservation	
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 2, 3, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 2, 3, '2016-07-29');/* --> Message d'erreur ICI */
/* Scénario:
	Faire plus de 5 reservations 
	Un utilisatuer 1 va emprunter tout les doc de 31-> 36 de la bibliotheque 1 (idExemplaire = 141-> 146)
	User 2 va reserver tous les doc de 31->35 et en ajoute une autre. Message d'erreur
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 142);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 143);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 144);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 145);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 146);

INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 31, 1, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 32, 1, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 33, 1, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 34, 1, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 35, 1, '2016-07-29');
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 36, 1, '2016-07-29');/* ERREUR ICI, 6eme reservation ! */

/* Scénario:
	Faire une reservation par un utilisateur qui à un document en retard */
update dateCourante set datecourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 1);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (2, 141);/* Doc 31 devient non disponible Pour qu'on puisse le reserver après */
UPDATE dateCourante set DateCourante = '2016-07-13'; /* Le document devient en retard */
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(1, 31, 1, '2016-07-29');

/* Scénario:
	Reserver un document qui a des exemplaire disponible dans la bibliotheque */
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(1, 31, 1, '2016-07-29');

/* Scénario:
	Faire une reservation normale, pour voir la génération automatique des dates:
	USer 1 emprunte un document (31) depuis la bibliotheque 1 -> Exemplaire = 141
	USER 2 fait une reservation de ce document dans la bibliotheque 1.
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);
INSERT INTO Reservation (idUser, idDocument, idBibliotheque, dateReserve) VALUES
		(2, 31, 1, '2016-06-14');
SELECT * FROM Reservation WHERE idUser = 2 AND idDocument = 31 AND idBibliotheque = 1;

