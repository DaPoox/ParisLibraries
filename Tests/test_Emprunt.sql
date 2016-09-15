/* Date courante = 2016-04-25 */
/* Scénario: 
	Faire un pret depuis un compte suspendu ou bloqué: */
UPDATE DateCourante set DateCourante = '2016-04-25';
UPDATE Utilisateur set etatAbonnement = 'suspendu' WHERE IdUser = 1;
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);

UPDATE Utilisateur SET etatAbonnement = 'bloque' WHERE idUser = 1;
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);

/* Scénario:
	Emprunter deux fois le meme exemplaire par le meme utilisateurs
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 141);

/* Scénario:
	Empruter un exemplaire déjà emprunté par un autre utilisateur.
*/
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 141);
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (2, 141);

/* Scénario:
	User Type Gratuit: Emprunter un cd/dvd 
	USER 2 (Gratuite), Exemplaire 21 (CD)
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (2, 21);
/* Scénario:
	User type CD Emprunter un DVD
	USER 3 (CD), Exemplaire 32 (DVD)
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (3, 32);
/* Scénatio 
	User type cd/dvd, Emprunter un livre
	USER 1, Exemplaire 42 (Livre)
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 42);
/* Scénario:
	Emprunter un document pour adult par un enfants
	User 8 (-18 ans), Exemplaire: 53 (Adult)
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (8, 53);
/* Scénario
	Emprunter plus que limit format:
	Format: CD, limit = 5. Exemplaires: 21, 22, 23, 24, 25, 26, 27
*/
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 21);
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 22);
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 23);
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 24);
INSERT INTO Emprunt (idUSer, idExemplaire) VALUES (1, 25);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 26);/* Ceci va declencher l'erreur */

/* Scénario:
	Emprunt plus que limit nouveauté bibliotheque
	Bibliotheque 1 (limitNouveaute = 4)
	Exemplaire: 1, 2, 3, 4, 5
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 1);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 2);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 3);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 4);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 5);/* Ceci va declencher l'erreur*/

/* Scénario:
	Emprunter plus que limit document dans une bibliotheque;
	bibliotheque 3(limit doc = 5);
	Exemplaires: 18, 19, 20, 50, 51, 52
*/
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 18);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 19);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 20);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 50);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 51);
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 52);

/* SCénario:
	Emprunt sans erreur, pour voir la génération des dates */
/* Hiver */
Update DateCourante set DateCourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 18);
SELECT * from Emprunt where idUser = 1 AND idExemplaire = 18;
/*ETE*/
DELETE FROM Emprunt;
UPDATE dateCourante set dateCourante = '2016-07-12';
INSERT INTO Emprunt(idUser, idExemplaire) VALUES (20, 19);
SELECT * FROM Emprunt WHERE idUser = 20 AND idExemplaire = 19;

/* Scénario:
	Renouveller un emprunt...1 fois, 2 fois, 3 fois 
	VOIR la mise a jour de nbRenouvellement, ainsi que la dateRetourPrevu après chaque renouvellement.
*/
UPDATE dateCourante set dateCourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 18);
UPDATE Emprunt set nbRenouvellement = nbRenouvellement + 1 WHERE idUser = 1 AND idExemplaire = 18;/* 1ere fois */
SELECT * FROM Emprunt;
UPDATE Emprunt set nbRenouvellement = nbRenouvellement + 1 WHERE idUser = 1 AND idExemplaire = 18;/* 2eme fois */
SELECT * FROM Emprunt;
UPDATE Emprunt set nbRenouvellement = nbRenouvellement + 1 WHERE idUser = 1 AND idExemplaire = 18;/* 3eme fois --> Erreur */
SELECT * FROM Emprunt;

/* Scénario:
	Renouveller un document en retard:
*/
UPDATE DateCourante set dateCourante = '2016-04-25';
INSERT INTO Emprunt (idUser, idExemplaire) VALUES (1, 18);
UPDATE dateCourante set dateCourante = '2016-05-17';
UPDATE Emprunt SET nbRenouvellement = nbRenouvellement + 1 WHERE idUser = 1 AND idExemplaire = 18;/* MEssage erreur ICI */

