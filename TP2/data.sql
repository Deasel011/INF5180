delete from AuteurASoumission;
delete from Evaluation;
delete from Soumission;
delete from Membre;
delete from TrackASujet;
delete from Sujet;
delete from CoPresident;
delete from ComiteRelecture;
delete from Chercheur;
delete from Track;
delete from Edition;
delete from Conference;


alter session set nls_date_format = 'dd.mm.yyyy';

-- titre,arbreviation,féruence,
INSERT INTO Conference (titre,acronyme,frequence) VALUES ('Symposium de Pataphysique Appliquée','SPA',6);
INSERT INTO Conference (titre,acronyme,frequence) VALUES ('SIAM Data Mining','SDM',12);

-- idÉdition,titre,lieu,début,fin
INSERT INTO Edition VALUES (1,'Symposium de Pataphysique Appliquée','Paris','11.04.2017','15.04.2017');
INSERT INTO Edition VALUES (2,'Symposium de Pataphysique Appliquée','New York','15.10.2017','19.10.2017');
INSERT INTO Edition VALUES (3,'SIAM Data Mining' ,'Houston','27.04.2017','29.04.2017');
INSERT INTO Edition VALUES (4,'SIAM Data Mining' ,'San Diego','03.05.2018','05.05.2018');

-- idTrack,idÉdition,titre,description,nbMaxPapiers,nbMaxPapiers
INSERT INTO Track VALUES (1,1,'Biomedical','Applications biomédicales de la pataphysique',2,6);
INSERT INTO Track VALUES (2,1,'Didactique','Didactique de la pataphysique',2,6);
INSERT INTO Track VALUES (3,2,'Didactique','Didactique avancée de la pataphysique',2,6);
INSERT INTO Track VALUES (4,2,'Informatique','Informatisation des outils pataphysiques',2,6);
INSERT INTO Track VALUES (5,3,'Graph Mining','Mining complex graphs',2,4);
INSERT INTO Track VALUES (6,3,'Deep Learning','Classification in the deep',2,4);
INSERT INTO Track VALUES (7,3,'Graph Mining','Mining heterogeneous networks',2,4);
INSERT INTO Track VALUES (8,3,'Deep Learning','Classification the very deep',2,4);
INSERT INTO Track VALUES (9,1,'TEST','TEST',2,4);


-- idChercheur,nom,prénom,adresse,courriel
INSERT INTO Chercheur VALUES (1,'Deslisle','Xavier','xavier.deslisle@e-conf.org');
INSERT INTO Chercheur VALUES (2,'Capitaine','Milène','milene.capitaine@e-conf.org');
INSERT INTO Chercheur VALUES (3,'Wouawad','Hajdi','hajdi.wouawad@e-conf.org');
INSERT INTO Chercheur VALUES (4,'Dutoit','René','rene.dutoit@e-conf.org');
INSERT INTO Chercheur VALUES (5,'Strumpf','Helmut','helmut.strumpf@e-conf.org');
INSERT INTO Chercheur VALUES (6,'Gregoriano','Bruno','bruno.gregoriano@e-conf.org');
INSERT INTO Chercheur VALUES (7,'Missoukov','Vladimir','vladimir.missoukov@e-conf.org');
INSERT INTO Chercheur VALUES (8,'Nakamura','Tiropito','tiropito.nakamura@e-conf.org');
INSERT INTO Chercheur VALUES (9,'Blaassen','Wilem','wilem.blaasem@e-conf.org');
INSERT INTO Chercheur VALUES (10,'Fred','O’Henry','ohenry.fred@e-conf.org');
INSERT INTO Chercheur VALUES (11,'Nora','Olssen','olssen.nora@e-conf.org');
INSERT INTO Chercheur VALUES (12,'Jeyong','Park','park.jeyong@e-conf.org');
INSERT INTO Chercheur VALUES (13,'Rakesh','Gupta','gupta.rakesh@e-conf.org');
INSERT INTO Chercheur VALUES (14,'Ian','Holmes','holmes.ian@e-conf.org');
INSERT INTO Chercheur VALUES (15,'Dolores','Cruz','cruz.dolores@e-conf.org');
INSERT INTO Chercheur VALUES (16,'Tadeusz','Hvostovski','hvostovski.tadeusz@e-conf.org');
INSERT INTO Chercheur VALUES (17, 'Flanagan','David','david.flanagan@e-conf.org');
INSERT INTO Chercheur VALUES (18, 'Nassar','Nazih','nazih.nassar@e-conf.org');
INSERT INTO Chercheur VALUES (19,'Mario','Luigi','luigi.mario@e-conf.org');
INSERT INTO Chercheur VALUES (20,'Trahan','Terry','terry.trahan@e-conf.org');
INSERT INTO Chercheur VALUES (21,'Auberjonois','Aubin','aubinauberjonois@e-conf.org');
INSERT INTO Chercheur VALUES (22,'Jaeger','Patrick','patrick.jaeger@e-conf.org');
INSERT INTO Chercheur VALUES (23, 'Wan','Chang','chang.wan@e-conf.org');
INSERT INTO Chercheur VALUES (24,'Pépin','Marsilius','marsilius.pepin@e-conf.org');
INSERT INTO Chercheur VALUES (25,'Ribeiro','Davi','davi.ribeiro@e-conf.org');
INSERT INTO Chercheur VALUES (26,'Davison','Katherine','katherine.davison@e-conf.org');



--idTrack,idComité,
INSERT INTO ComiteRelecture VALUES (11,1);
INSERT INTO ComiteRelecture VALUES (12,2);
INSERT INTO ComiteRelecture VALUES (13,3);
INSERT INTO ComiteRelecture VALUES (14,4);
INSERT INTO ComiteRelecture VALUES (15,5);
INSERT INTO ComiteRelecture VALUES (16,6);
INSERT INTO ComiteRelecture VALUES (17,7);
INSERT INTO ComiteRelecture VALUES (18,8);
INSERT INTO ComiteRelecture VALUES (19,9);


--idComité,idChercheur
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (11,1);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (11,4);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (12,2);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (12,3);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (13,3);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (13,2);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (14,8);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (14,4);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (15,16);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (15,10);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (16,6);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (16,8);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (17,7);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (17,10);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (18,8);
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (18,9);


-- idSujet,motClef
INSERT INTO Sujet VALUES (21,'homéopathie');
INSERT INTO Sujet VALUES (22,'systèmique');
INSERT INTO Sujet VALUES (23,'épidémiologie');
INSERT INTO Sujet VALUES (24,'primaire');
INSERT INTO Sujet VALUES (25,'didactique');
INSERT INTO Sujet VALUES (26,'psychanalyse');
INSERT INTO Sujet VALUES (27,'quantique');
INSERT INTO Sujet VALUES (28,'parallèle');
INSERT INTO Sujet VALUES (29,'efficacité');
INSERT INTO Sujet VALUES (30,'hypergraphs');
INSERT INTO Sujet VALUES (31,'Big Data');
INSERT INTO Sujet VALUES (32,'heterogeneous networks');
INSERT INTO Sujet VALUES (33,'neuro decision trees');
INSERT INTO Sujet VALUES (34,'neural nets');
INSERT INTO Sujet VALUES (35,'recurrent architectures');
INSERT INTO Sujet VALUES (36,'convolution');


--idTrack,idSujet
insert into TrackASujet values (1,21);
insert into TrackASujet values (1,22);
insert into TrackASujet values (1,23);
insert into TrackASujet values (2,24);
insert into TrackASujet values (2,25);
insert into TrackASujet values (2,26);
insert into TrackASujet values (3,24);
insert into TrackASujet values (3,25);
insert into TrackASujet values (3,26);
insert into TrackASujet values (4,27);
insert into TrackASujet values (4,28);
insert into TrackASujet values (4,29);
insert into TrackASujet values (5,30);
insert into TrackASujet values (5,31);
insert into TrackASujet values (5,32);
insert into TrackASujet values (6,34);
insert into TrackASujet values (6,35);
insert into TrackASujet values (6,29);
insert into TrackASujet values (6,36);
insert into TrackASujet values (7,30);
insert into TrackASujet values (7,31);
insert into TrackASujet values (7,33);
insert into TrackASujet values (8,34);
insert into TrackASujet values (8,35);
insert into TrackASujet values (8,36);
insert into TrackASujet values (8,31);




--idComité,idChercheur
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (11,3);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (11,5);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (11,6);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (12,1);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (12,4);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (12,7);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (13,4);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (13,1);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (13,7);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (14,3);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (14,9);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (14,11);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (15,12);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (15,8);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (15,14);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (16,13);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (16,11);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (16,9);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (17,8);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (17,14);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (17,15);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (18,13);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (18,9);
INSERT INTO Membre (idComiteRelecture,idChercheur) VALUES (18,2);




-- noSoumission,titre,résumé,corps
insert into Soumission values (1,'La pataphysique homéopathique et ses bienfaits connus','bla-bla','tiny.url',1);
insert into Soumission values (2,'L’approche systémique en pataphysiologie','bla-bla','tiny.url',2);
insert into Soumission values (3,'Revue critique des théories pataphydiques en épidémiologie','bla-bla','tiny.url',1);
insert into Soumission values (4,'Enseignement de la pataphysique au primaire','bla-bla','tiny.url',2);
insert into Soumission values (5,'Vers une nouvelle didactique de la pataphysique','bla-bla','tiny.url',1);
insert into Soumission values (6,'Comparaison des cours de pataphysique et de psychanalyse','bla-bla','tiny.url',2);
insert into Soumission values (7,'Education et pataphysique : un nouveau contrat social','bla-bla','tiny.url',3);
insert into Soumission values (8,'Pataphysique : science, philosophie et escroquerie','bla-bla','tiny.url',3);
insert into Soumission values (9,'Pate-à-sel et pataphysique : construire l''enseignement du futur','bla-bla','tiny.url',3);
insert into Soumission values (10,'Vers des outils pataphysiques adaptés : un état de l''art','bla-bla','tiny.url',4);
insert into Soumission values (11,'Le calendrier pataphysique, une approche holistique ','bla-bla','tiny.url',4);
insert into Soumission values (12,'Des outils imaginaires pour des solutions imaginaires','bla-bla','tiny.url',4);
insert into Soumission values (13,'NewSQL : une approche relationelle solide pour une analyse de graphes robuste','bla-bla','tiny.url',5);
insert into Soumission values (14,'Book embedding, réduction des espaces de recherche dans l''analyse de graphes complexes','bla-bla','tiny.url',5);
insert into Soumission values (15,'Fonctions noyaux de graphes : extraction de caracteristiques dans des espaces infinis','bla-bla','tiny.url',5);
insert into Soumission values (16,'Deep learning : une composition de problèmes convexes et ses solutions alternatives','bla-bla','tiny.url',6);
insert into Soumission values (17,'L''influence des modèles distribués sur les langages de programmation','bla-bla','tiny.url',6);
insert into Soumission values (18,'Cryptage à faible consommation d''énergie pour les table de partition dans les architectures distribueés','bla-bla','tiny.url',6);
insert into Soumission values (19,'De l''exploration des arbres suffixes','bla-bla','tiny.url',7);
insert into Soumission values (20,'Émulation de la tolérance aux pannes byzantines et des protocoles','bla-bla','tiny.url',7);
insert into Soumission values (21,'Analyse de la vérification du modèle et de la redondance','bla-bla','tiny.url',7);
insert into Soumission values (22,'Abyss : la singularité, une question de couches ?','bla-bla','tiny.url',8);
insert into Soumission values (23,'L''influence de la théorie aléatoire sur l''ingénierie du logiciel d''autoapprentissage','bla-bla','tiny.url',8);
insert into Soumission values (24,'Un cas pour la loi de Moore','bla-bla','tiny.url',8);
insert into Soumission values (25,'test','test','test.url',9);

-- idComité,idChercheur,noSoumission,note
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (11,5,1);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (11,3,2);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (11,6,3);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (12,1,4);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (12,7,5);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (12,4,6);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (13,4,7);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (13,7,8);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (13,7,9);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (14,3,10);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (14,3,11);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (14,11,12);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (15,12,13);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (15,12,14);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (15,12,15);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (16,11,16);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (16,13,17);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (16,13,18);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,8,19);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,14,20);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,8,21);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (18,13,22);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (18,2,23);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (18,9,24);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (11,6,1);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (11,6,2);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (12,1,5);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (13,1,7);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (13,4,8);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (14,9,10);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (15,8,13);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (16,9,16);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,14,19);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,15,20);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,14,21);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (18,2,24);
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (17,15,19);


-- idChercheur;insoumission,rang
--insert into AuteurASoumission values(1,1,1);
insert into AuteurASoumission values(3,1,2);
--insert into AuteurASoumission values(2,2,1);
insert into AuteurASoumission values(7,2,2);
insert into AuteurASoumission values(11,2,3);
insert into AuteurASoumission values(5,3,1);
--insert into AuteurASoumission values(1,3,2);
insert into AuteurASoumission values(9,3,3);
insert into AuteurASoumission values(10,4,1);
insert into AuteurASoumission values(14,4,2);
insert into AuteurASoumission values(8,5,1);
--insert into AuteurASoumission values(4,5,2);
insert into AuteurASoumission values(6,5,3);
insert into AuteurASoumission values(12,6,1);
insert into AuteurASoumission values(10,7,2);
insert into AuteurASoumission values(14,7,1);
insert into AuteurASoumission values(15,8,1);
insert into AuteurASoumission values(16,9,1);
--insert into AuteurASoumission values(2,9,2);
insert into AuteurASoumission values(11,9,3);
insert into AuteurASoumission values(14,10,1);
insert into AuteurASoumission values(12,10,2);
insert into AuteurASoumission values(16,11,1);
insert into AuteurASoumission values(17,11,2);
insert into AuteurASoumission values(22,12,1);
insert into AuteurASoumission values(23,12,2);
insert into AuteurASoumission values(20,13,1);
insert into AuteurASoumission values(21,14,1);
insert into AuteurASoumission values(23,15,1);
insert into AuteurASoumission values(22,15,2);
insert into AuteurASoumission values(24,16,1);
insert into AuteurASoumission values(22,16,2);
insert into AuteurASoumission values(18,17,1);
insert into AuteurASoumission values(20,18,1);
insert into AuteurASoumission values(19,18,2);
insert into AuteurASoumission values(19,19,1);
insert into AuteurASoumission values(21,19,2);
insert into AuteurASoumission values(25,20,1);
insert into AuteurASoumission values(18,20,2);
insert into AuteurASoumission values(24,20,3);
insert into AuteurASoumission values(15,21,1);
insert into AuteurASoumission values(17,22,1);
insert into AuteurASoumission values(16,22,2);
insert into AuteurASoumission values(26,23,1);
insert into AuteurASoumission values(16,24,1);
insert into AuteurASoumission values(17,24,2);
insert into AuteurASoumission values(18,24,3);
insert into AuteurASoumission values(1,25,1);

