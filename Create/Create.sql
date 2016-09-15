/*
	Création des tables:
*/

/*
	Date (Table désignant la date "courante"
	DateCourante(dateCourante)
*/
CREATE TABLE DateCourante(
	dateCourante Date NOT NULL);
INSERT INTO DateCourante VALUES ('2016-09-15');

/* User: 
	User(idUser, Nom, Prenom, DateNaissance, Email, Adresse, TypeInscription, DateInscription, DateExpiration, EtatAbonnement)
*/
CREATE TABLE Utilisateur(
	idUser serial PRIMARY KEY, /* Serial pour AUTO_INCREMENT */
	nom varchar(20) NOT NULL,
	prenom varchar(20) NOT NULL, 
	dateNaissance Date NOT NULL,
	email varchar(50),
	adresse Text NOT NULL,
	typeInscription varchar(10) CHECK (typeInscription IN ('gratuite', 'cd', 'cd/dvd')) DEFAULT 'gratuite',
	dateInscription Date NOT NULL, /* Trigger pour vérifier avec la date courante */
	dateExpiration Date NOT NULL,  /* Trigger pour vérifier avec la date courante */
	etatAbonnement Varchar(10) CHECK (etatAbonnement IN ('normal', 'suspendu', 'bloque')),
	penalite integer DEFAULT 0	
);
/* Bibliotheque: 
	Bibliotheque(Nom, Adresse, Email, Telephone, LimitDoc, LimitNouveaute)
*/
/* MODIFIER */
CREATE TABLE Bibliotheque(
	idBibliotheque serial PRIMARY KEY,
	nom varchar(100) NOT NULL,
	adresse Text NOT NULL, 
	email varchar(50),
	telephone varchar(15) CHECK (telephone LIKE '^[0-9]+'),
	limitDoc integer NOT NULL CHECK (limitDoc > 0),
	limitNouveaute integer NOT NULL CHECK (limitNouveaute > 0)
);

/* Auteur:
	Auteur(idAuteur, Nom, Prenom);
*/
CREATE TABLE Auteur(
	idAuteur serial PRIMARY KEY,
	nom varchar(20) NOT NULL,
	prenom varchar(20) NOT NULL
);
/* Format: 
	Format(nom, limitFormat);
*/
CREATE TABLE Format(
	nom varchar(20) PRIMARY KEY,
	limitFormat integer NOT NULL CHECK (limitFormat > 0)
);

/* Genre: 
	Genre(Nom, Libelle):
*/
CREATE TABLE Genre(
	nom varchar(20) PRIMARY KEY,
	libelle varchar(50)
);
/* Document:	
	Document(idDocument, Titre, Format*, Genre*, Langue, ISBN, Annee, Categorie, Edition, editeur)
*/
CREATE TABLE Document(
	idDocument serial PRIMARY KEY,
	titre varchar(200) NOT NULL,
	idAuteur integer REFERENCES Auteur(idAuteur),
	format varchar(20) REFERENCES Format(nom),
	genre varchar(20) REFERENCES Genre(nom),
	langue varchar(20) NOT NULL,
	ISBN varchar(20),
	annee varchar(4),
	categorie varchar(20) NOT NULL CHECK (categorie IN ('adult', 'enfant', 'tout')) DEFAULT 'tout',
	editeur varchar(50),
	edition integer
);

/* * ** * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* Exemplaire: 
	Exemplaire(idexemplaire, idDocument*, idBibliotheque*, prixAchat)
	*/
CREATE TABLE Exemplaire(
	idExemplaire serial PRIMARY KEY,
	idDocument integer REFERENCES Document(idDocument),
	idBibliotheque integer REFERENCES Bibliotheque(idBibliotheque),
	dateAchat Date, 
	prixAchat integer
);

/* Emprunt 
	Emprunt(idEmprunt, idUser*, idExemplaire*, DateEmprunt, DateRetourPrevu, nbRenouvellement);
	*/
CREATE TABLE Emprunt(
	idEmprunt serial PRIMARY KEY,
	idUser integer NOT NULL REFERENCES Utilisateur(idUser),
	idExemplaire integer NOT NULL REFERENCES Exemplaire(idExemplaire),
	dateEmprunt date NOT NULL,
	DateRetourPrevu date, /* TRIGGER TO ADD THIS */
	nbRenouvellement integer DEFAULT 0 CHECK (nbRenouvellement <3)
);

/*
	Retour:
		Retour(idRetour, idUser*, idExemplaire*, dateRetour)
		*/
CREATE TABLE Retour(
	idRetour serial PRIMARY KEY,
	idUser integer NOT NULL REFERENCES Utilisateur(idUser),
	idExemplaire integer NOT NULL REFERENCES Exemplaire(idExemplaire),
	dateRetour date NOT NULL,/* Trigger, check constraint pdf */
	dateEmprunt date NOT NULL
);

/* Reservation:
	Reservation(idReservation, idUser*, idDocument*, idBibliotheque*, dateReserve)
	*/
CREATE TABLE Reservation(
	idReservation serial PRIMARY KEY,
	idUser integer NOT NULL REFERENCES Utilisateur(idUser),
	idDocument integer NOT NULL REFERENCES Document(idDocument),
	idBibliotheque integer NOT NULL REFERENCES Bibliotheque(idBibliotheque),
	dateReserve date NOT NULL,
	dateReservation Date NOT NULL
);
