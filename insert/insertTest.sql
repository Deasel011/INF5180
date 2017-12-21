--
-- creation track et soumission
--
insert into TRACK (idTrack,idEdition,titre,description,nbMinPapiers,nbMaxPapiers) values(9,3,'Track pour test','test de contrainte',2,4);
insert into COMITERELECTURE (idTrack,idComite)  values(9,19);
insert into SOUMISSION (noSoumission,titre,resume,corps, idTrack) values(25,'Test de contrainte','bla-bla','tiny-url', 9);
insert into SOUMISSION (noSoumission,titre,resume,corps, idTrack) values(26,'Test de contrainte2','bla-bla','tiny-url', 9);
insert into CHERCHEUR (idChercheur,nom,prenom,adresse) values(26,'Bob','Test','Nowhere College');
insert into CHERCHEUR (idChercheur,nom,prenom,adresse) values(27,'Bobby','CoAuteur','Nowhere College');
insert into CHERCHEUR (idChercheur,nom,prenom,adresse) values(28,'Arthur','President','Nowhere College');
--
-- Check
--
insert into EDITION (idEdition,titre,venue,datedebut,datefin) values (5,'test contrainte date Edition','Paris', TO_DATE('04/15/2017 00:00:00', 'MM/DD/YYYY hh24:mi:ss'), TO_DATE('04/11/2017 00:00:00', 'MM/DD/YYYY hh24:mi:ss'));
insert into TRACK (idTrack,idEdition,titre,description,nbMinPapiers,nbMaxPapiers) values(9,1,'testTrack','test contrainte nbPapier table track',6,2);
--
-- Test max 2 copresident
--
insert into COPRESIDENT (idComite,idChercheur) values(19,26);
insert into COPRESIDENT (idComite,idChercheur) values(19,27);
insert into COPRESIDENT (idComite,idChercheur) values(19,28);
delete from COPRESIDENT where idChercheur = 26;
delete from COPRESIDENT where idChercheur = 27;
delete from COPRESIDENT where idChercheur = 28;
--
-- test max 3 eval par membre
--
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,1,0);
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,2,0);
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,3,0);
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,4,0);
delete from EVALUATION where idChercheur = 26;
--
-- test Auteur Copresident meme track insert auteur first
--
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(28,25,1);
insert into COPRESIDENT (idComite,idChercheur) values(19,28);
delete from AUTEURASOUMISSION where idChercheur = 28;
--
-- test Auteur Copresident meme track insert copresident first
--
insert into COPRESIDENT (idComite,idChercheur) values(19,28);
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(28,25,1);	
delete from COPRESIDENT where idChercheur = 28;
--
-- test Evaluation coauteur insertion Auteur
--
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,26,0);
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(26,25,1);
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(27,25,1);
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(27,26,1);
delete from AUTEURASOUMISSION where idChercheur = 26;
delete from AUTEURASOUMISSION where idChercheur = 27;
delete from EVALUATION where idChercheur = 26;
--
-- test Evaluation coauteur insertion Evaluation
--
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(26,25,1);
insert into AUTEURASOUMISSION (idChercheur,idSoumission,rang) values(27,25,1);
insert into EVALUATION (idComite,idChercheur,noSoumission,note) values (19,26,26,0);
delete from AUTEURASOUMISSION where idChercheur = 26;
delete from AUTEURASOUMISSION where idChercheur = 27;
delete from EVALUATION where idChercheur = 26;
select * from dual;

