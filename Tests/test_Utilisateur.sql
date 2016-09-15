
/******* date courante  2016-04-25

/**date de naissance > date courante**/
INSERT INTO Utilisateur (nom, prenom, dateNaissance, email, adresse, typeInscription) VALUES ('jhon', 'jhon', '2016-12-09', 'tounsi@gmail.com', '35 Rue rue Ville 98766 FRANCE', 'gratuite');

/***** date naissance normal et voir les initialisation******/

INSERT INTO Utilisateur (nom, prenom, dateNaissance, email, adresse, typeInscription) VALUES ('jhon', 'jhon', '2000-12-09', 'tounsi@gmail.com', '35 Rue rue Ville 98766 FRANCE', 'gratuite');
select iduser, nom from utilisateur where nom = 'jhon';
delete from utilisateur where nom ='jhon' and prenom='jhon';

/******Ajouter un emprunt à cet utilisateur, modifier la datecourante pour qu'il soit en retard et générer une pénalité. Payer la pénalité en la mettant à 0 (Tout en laissant le document en retard (voir user reste suspendu), et une deuxième fois en rendant le document (voir user devient normal)******/
/** a l'examin changer id user */
/**1)**/
insert into emprunt (iduser,idexemplaire) values (6,23); /*date courante*/

update datecourante set datecourante='2016-05-20'
select iduser, nom from utilisateur where iduser = 6;

/*voir etat utilisateur penalite*/


update datecourante set datecourante='2016-04-25'
delete from emprunt where idexempalire=23;
update utilisateur set etatabonnement = 'normal' where iduser=6;
update utilisateur set penalite = 0 where iduser=6;


/**2)**/
/*chager la date*/

 insert into retour(iduser,idexemplaire) values(6,23);
 update datecourante set datecourante='2016-05-20'
/*voir etat suspendu --> noraml  penalite>0 ===> */

update utilisateur set penalite = 0 where iduser=6;	



