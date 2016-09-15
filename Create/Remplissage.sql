/* Script pour remplissage des tables de la base de données */ 

/* Utilisateur; */
INSERT INTO Utilisateur 
	(nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES 	('Kerris', 'Abderrahmane', '1993-12-09', 'abderrahmane.kerris@gmail.com', '35 Rue rue Ville 98766 FRANCE', 'cd/dvd', '2016-02-02', '2017-02-02', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Tounsi', 'Abdelkader', '1987-07-09', 'tounsi.abdelkader@hotmail.com', '1 Impasse soufflout garges les gonesse 95140', 'gratuite', '2016-06-23', '2017-06-23', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Tounsi', 'Moussa', '1986-12-09', 'moussa2300@hotmail.com', '1 impasse soufflout garges les gonesse sarcelle 95140 FRANCE', 'cd', '2015-09-01', '2016-09-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Hakim', 'Toufik', '1990-06-09', 'Hakim.toufik@hotmail.com', '1  garges les gonesse 95140', 'cd/dvd', '2015-05-11', ' 2017-09-01', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Lamine', 'Mohamed', '1990-11-01', 'lamine.mohamed@gmail.com', '36 Rue rue Ville 95160 FRANCE', 'gratuite', '2016-09-01', '2017-09-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('sophie', 'dina', '1990-06-09', 'sophie.dina@hotmail.fr', '1 Impasse soufflout  saint denis 95150', 'cd/dvd', '2016-09-11', '2017-09-11', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('steve', 'jobs', '1975-12-09', 'steve.jobs@hotmail.com', '1  rue avenude de france 75140 FRANCE', 'gratuite', '2015-11-01', '2016-11-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('carton', 'sal3a', '1960-07-09', 'carton.sal3a@hotmail.com', '40 rue de roi val doise 9500 FRANCE', 'cd', '2016-01-11', '2017-01-11', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('jean', 'baptiste', '1970-05-11', '35 Rue rue Ville 98766 FRANCE', 'cd/dvd', '2015-09-11', '2016-09-11', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('marian', 'sara', '1993-04-11', 'marian@hotmail.com', '1 Rue  hakeim  75140  FRANCE', 'cd', '2016-05-11', '2017-05-11', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('mario', 'broos', '1970-01-09', 'broos@hotmail.fr', '1 rue de roi 3 val doisse  95140', 'cd', '2015-09-01', '2016-09-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Hakim', 'hakim', '1990-06-09', 'Hakim@hotmail.com', '1 Avenue de france 75140 France', 'cd/dvd', '2015-05-11', '2016-05-11', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('Lamine', 'Mohamed', '1990-11-01', 'lamine.mohamed@gmail.com', '36 Rue rue Ville 95160 FRANCE', 'gratuite', '2016-09-01', '2017-09-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('sara', 'jihane', '1990-07-11', 'jihane@gmail.fr', '1 rue de france val de marne 95100 France', 'cd/dvd', '2016-05-10', '2017-05-10', 'normal');

INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('isabel', 'marine', '1985-11-11', 'marian@gmail.com', '1  rue avenude de france 75002 FRANCE', 'gratuite', '2015-11-01', '2016-11-01', 'normal');
INSERT INTO Utilisateur  (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES  ('sophie', 'germain', '1960-08-19', 'germain@hotmail.com', '40 rue de prince paris 75000 FRANCE', 'cd', '2016-01-11', '2017-01-11', 'normal');
INSERT INTO Utilisateur (nom, prenom, dateNaissance, email, adresse, typeInscription, dateInscription, dateExpiration, etatAbonnement)
	VALUES ('enfant', 'enfant', '2004-12-09', 'enfant.enfant@gmail.com', '35 Rue rue Ville 98766 FRANCE', 'gratuite', '2015-01-12', '2016-01-12', 'normal');

/* Bibliotheque */
INSERT INTO Bibliotheque (nom, adresse, email, telephone, limitDoc, limitNouveaute) Values ('Grands Moulins', ' 5 Rue Thomas Mann, 75013 Paris', '', '0157276671', 20, 4);
INSERT INTO Bibliotheque (nom, adresse, email, telephone, limitDoc, limitNouveaute) Values ('Bulac', '65 Rue des Grands Moulins, 75013 Paris', '', '0181691800', 100, 20);
INSERT INTO Bibliotheque (nom, adresse, email, telephone, limitDoc, limitNouveaute) Values ('Bibliothèque nationale de France', 'Quai François Mauriac, 75013 Paris', '', '0153795959', 5, 20);

/* Format */
INSERT INTO Format Values('cd', 5);
INSERT INTO Format Values ('dvd', 3);
INSERT INTO Format Values ('livre', 40);

/* Genre */
INSERT INTO Genre (nom) Values ('informatique');
INSERT INTO Genre (nom) Values ('physique');
INSERT INTO Genre (nom, libelle) Values ('math', 'mathematique');
INSERT INTO Genre (nom, libelle) Values ('bd', 'bande déssinée');
INSERT INTO Genre (nom) Values ('policier');
INSERT INTO Genre (nom) Values ('humour');
INSERT INTO Genre (nom) Values ('aventure');

/* Auteur */

INSERT INTO Auteur (nom, prenom) VALUES ('grenier', 'christian');
INSERT INTO Auteur (nom, prenom) VALUES ('Didier', 'Anne');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA1', 'prenomA1');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA2', 'prenomA2');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA3', 'prenomA3');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA4', 'prenomA4');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA5', 'prenomA5');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA6', 'prenomA6');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA7', 'prenomA7');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA8', 'prenomA8');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA9', 'prenomA9');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA10', 'prenomA10');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA11', 'prenomA11');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA12', 'prenomA12');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA13', 'prenomA13');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA14', 'prenomA14');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA15', 'prenomA15');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA16', 'prenomA16');
INSERT INTO Auteur (nom, prenom) VALUES ('nomA17', 'prenomA17');

/* Document */
/**aventure*/
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventure 1','livre', 2, 'aventure', 'fr' , '2-7005-2536-1', '2000', 'enfant', 'editeur1', 1);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventude 2', 'livre', 1,'aventure', 'fr', '2-7004-1523-2', '1996', 'adult', 'editeur2', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventure 3','livre', 4, 'aventure', 'fr' , '2-2015-2537-1', '2014', 'tout', 'editeur3', 3);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventude 4', 'cd', 9,'aventure', 'fr', '2-2015-1513-2', '2015', 'adult', 'editeur4', 4);
	INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventure 5','livre', 12, 'aventure', 'fr' , '2-2000-2836-1', '2000', 'enfant', 'editeur2', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventude 6', 'livre', 16,'aventure', 'fr', '2-1966-1523-2', '1996', 'tout', 'editeur3', 3);
	INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventure 7','livre', 17, 'aventure', 'en' , '2-7002-2456-1', '2002', 'tout', 'editeur3', 3);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre aventude 8', 'livre', 18,'aventure', 'en', '2-2015-1526-2', '2015', 'adult', 'editeur4', 4);

/***bd**/
INSERT INTO Document (titre, format, idAuteur, genre, langue, annee, categorie, editeur, edition) 
	VALUES ('titre bd 1', 'livre', 3,'bd', 'fr', '2005', 'enfant', 'editeur3', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
  VALUES ('titre bd 2', 'livre', 3,'bd', 'fr', '2-2003-3260-6', '2003', 'tout', 'editeur4', 4);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre bd 3', 'livre', 4,'bd', 'fr', '2-2005-3165-7', '2005', 'adult', 'editeur5', 5);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre bd 4', 'livre', 6,'bd', 'fr', '1-2008-3965-8', '2008', 'enfant', 'editeur4', 4);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre bd 5', 'livre', 5,'bd', 'fr', '1-2001-3165-9', '2001', 'adult', 'editeur5', 5);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre bd 6', 'livre', 7,'bd', 'fr', '2-2014-3275-10', '2014', 'tout', 'editeur1', 1);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre bd 7', 'livre', 7,'bd', 'fr', '2-2015-3255-11', '2015', 'enfant', 'editeur3', 3);

/****humour**/

INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition) 
	VALUES ('titre humour -1', 'livre', 7,'bd', 'fr', '2-2014-3275-10', '2014', 'tout', 'editeur1', 1);

INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition) 
	VALUES ('titre humour 0', 'livre', 7,'bd', 'fr', '2-2014-3275-10', '2014', 'tout', 'editeur1', 1);

INSERT INTO Document (titre, format, idAuteur, genre, langue, annee, categorie, editeur, edition) 
	VALUES ('titre humour 1', 'livre', 2,'humour', 'fr', '2005', 'enfant', 'editeur3', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
  VALUES ('titre humour 2', 'cd', 3,'humour', 'fr', '2-2003-2311-6', '2003', 'tout', 'editeur4', 4);
INSERT INTO Document (titre, format, idAuteur, genre, langue,  annee, categorie, editeur, edition)
	VALUES ('titre humour 3', 'dvd', 14,'humour', 'en', '2005', 'adult', 'editeur5', 5);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre humour 4', 'livre', 16,'humour', 'fr', '1-2008-3547-8', '2008', 'enfant', 'editeur4', 4);
/***policier*/	
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre policier 1', 'livre', 15, 'policier', 'fr','1-2550-1542-9', '2001', 'adult', 'editeur5', 5);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre policier 2', 'livre', 17, 'policier', 'en' ,'2-2451-7898-10', '2014', 'tout', 'editeur1', 1);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre policier 3', 'livre', 18,'policier', 'fr','2-2005-8997-11', '2015', 'enfant', 'editeur3', 3);
/**** math*****/

INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre math 1','livre', 4, 'math', 'fr' , '2-222-2437-1', '2016', 'tout', 'editeur3', 3);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre math 2', 'livre', 9,'math', 'fr', '2-1111-1513-2', '2015', 'tout', 'editeur4', 4);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre math 3','livre', 9, 'math', 'fr' , '2-5555-2836-1', '2015', 'tout', 'editeur2', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre math 4', 'livre', 16,'math', 'fr', '2-1871-1213-1', '1970', 'tout', 'editeur3', 3);

/**physique*/


INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre physique 1','livre', 5, 'physique', 'fr' , '5-5466-2437-1', '2016', 'tout', 'editeur3', 3);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre physique 2', 'livre', 9,'physique', 'fr', '1-177-1513-2', '2015', 'adult', 'editeur4', 4);
	INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre physique 3','livre', 7, 'physique', 'fr' , '5-5545-2886-4', '2000', 'enfant', 'editeur2', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre physique 4', 'livre', 18,'physique', 'fr', '9-1871-1213-4', '2015', 'tout', 'editeur3', 3);
/*** informatique**/

INSERT INTO Document (titre, format, idAuteur, genre, langue, annee, categorie, editeur, edition)
	VALUES ('titre informatique 1','cd', 5, 'informatique', 'fr' , '2016', 'tout', 'editeur5', 5);
INSERT INTO Document (titre, format, idAuteur, genre, langue,  annee, categorie, editeur, edition)
	VALUES ('titre informatique 2', 'dvd', 9,'informatique', 'fr', '2015', 'tout', 'editeur5', 5);

INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre informatique 3','livre', 5, 'informatique', 'fr' , '5-5545-2886-4', '2000', 'tout', 'editeur2', 2);
INSERT INTO Document (titre, format, idAuteur, genre, langue, isbn, annee, categorie, editeur, edition)
	VALUES ('titre informatique 4', 'livre', 18,'informatique', 'fr', '9-1871-1213-4', '2015', 'tout', 'editeur3', 3);
/* Exemplaire */

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 1, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 1, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 1, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (3, 1, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (3, 1, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 2, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 2, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 2, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 2, 25);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (3, 1, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (3, 1, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (3, 1, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (1, 3, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 3, 30);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (2, 3, 30);
/*************************************************** */
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 3, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 3, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 3, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 3, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (4, 2, 20);

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 2, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 1, 50);
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat)
	VALUES (21, 1, 50);
/* Attribuer une date d'achat au tuples inséré. Nous avons ajouter l'attribut date achat après avoir ajouté ces tuples... */
UPDATE Exemplaire SET dateAchat = '2016-03-12';

/* NEW STUFF */
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 1, 40, '2016-07-12');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 1, 40, '2016-04-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 1, 40, '2016-07-11');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 1, 40, '2016-07-11');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 2, 50, '2016-07-11');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 2, 50, '2016-07-03');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 2, 50, '2015-03-11');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 2, 50, '2015-01-04');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 2, 25, '2014-07-13');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (10, 3, 25, '2014-07-13');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 1, 70, '2016-07-13');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 2, 70, '2016-05-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 2, 70, '2016-05-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 2, 70, '2016-05-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 3, 70, '2016-03-09');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 3, 70, '2016-03-09');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 3, 70, '2016-03-09');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (11, 3, 70, '2016-03-09');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 1, 30, '2015-02-10');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 2, 30, '2015-12-30');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 2, 30, '2015-12-30');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 2, 30, '2015-12-30');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (12, 3, 30, '2016-06-23');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (13, 1, 45, '2015-08-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (13, 2, 45, '2016-07-23');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (13, 3, 45, '2016-12-09');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (14, 1, 20, '2016-02-20');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (14, 1, 20, '2016-02-20');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (14, 1, 20, '2016-02-20');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (14, 3, 20, '2016-02-20');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 1, 26, '2016-04-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 1, 26, '2016-04-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 1, 26, '2016-04-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 1, 26, '2016-04-15');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 2, 26, '2016-08-05');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 2, 26, '2016-08-05');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 2, 26, '2016-08-05');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 3, 26, '2016-06-15');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 3, 26, '2016-06-15');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 3, 26, '2016-06-15');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (15, 3, 26, '2016-06-15');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (16, 3, 30, '2016-05-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (16, 3, 30, '2016-05-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (16, 3, 30, '2016-05-14');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (18, 1, 38, '2015-02-14');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (18, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (18, 3, 38, '2015-12-12');

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (19, 2, 38, '2015-12-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (19, 2, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (19, 2, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (19, 2, 38, '2016-02-18');


/*22*/
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 1, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 1, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 1, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 1, 50,'2015-07-01');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (22, 2, 50,'2014-08-01');


/***23**/

INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 3, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 3, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 3, 50,'2015-07-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 3, 50,'2015-07-01');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 2, 50,'2014-08-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (23, 2, 50,'2014-08-01');

/**24***/


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 3, 50,'2015-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 3, 50,'2015-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 3, 50,'2015-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 3, 50,'2015-05-01');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 2, 50,'2014-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 2, 50,'2014-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 2, 50,'2014-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 2, 50,'2014-05-01');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat,dateAchat)
	VALUES (24, 2, 50,'2014-05-01');


INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (30, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (31, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (32, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (33, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (34, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (35, 1, 38, '2016-02-18');
INSERT INTO Exemplaire (idDocument, idBibliotheque, prixAchat, dateAchat)
	VALUES (36, 1, 38, '2016-02-18');


