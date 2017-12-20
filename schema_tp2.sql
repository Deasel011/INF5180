 -- noinspection SqlDialectInspectionForFile

-- noinspection SqlNoDataSourceInspectionForFile

set echo on;
set serveroutput on;

drop table Conference cascade constraints;
drop table Edition cascade constraints;
drop table Track cascade constraints;
drop table Chercheur cascade constraints;
drop table CoPresident cascade constraints;
drop table ComiteRelecture cascade constraints;
drop table Sujet cascade constraints;
drop table TrackASujet cascade constraints;
drop table Membre cascade constraints;
drop table Evaluation cascade constraints;
drop table Soumission cascade constraints;
drop table AuteurASoumission cascade constraints;

CREATE TABLE Conference
(
	titre VARCHAR(50) NOT NULL,
	acronyme VARCHAR(10) NOT NULL,
	frequence INTEGER NOT NULL,
	CONSTRAINT acronyme_unique UNIQUE(acronyme),
	CONSTRAINT conference_pk PRIMARY KEY (titre)
);

CREATE TABLE Edition
(
	idEdition INTEGER NOT NULL,
	titre VARCHAR(50) NOT NULL,
	venue VARCHAR(50) NOT NULL,
	dateDebut DATE NOT NULL,
	dateFin DATE NOT NULL,
	CONSTRAINT edition_pk PRIMARY KEY (idEdition),
	CONSTRAINT editiionConference_fk FOREIGN KEY (titre) REFERENCES Conference(titre),
	CONSTRAINT date_check CHECK (dateDebut <= dateFin)
);

CREATE TABLE Track
(
	idTrack INTEGER NOT NULL,
	idEdition INTEGER NOT NULL,
	titre VARCHAR(50) NOT NULL, 
	description VARCHAR (100) NOT NULL,
	nbMinPapiers NUMBER NOT NULL,
	nbMaxPapiers NUMBER NOT NULL,
	CONSTRAINT track_id PRIMARY KEY (idTrack),
	CONSTRAINT trackEdition_fk FOREIGN KEY (idEdition) REFERENCES Edition(idEdition),
	CONSTRAINT nbPapiers_check CHECK (nbMinPapiers <= nbMaxPapiers)
);

CREATE TABLE Chercheur
(
	idChercheur NUMBER NOT NULL,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	adresse VARCHAR(50) NOT NULL,
	CONSTRAINT chercheur_pk PRIMARY KEY (idChercheur)
);

CREATE TABLE ComiteRelecture
(
	idComite NUMBER NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT idTrack_unique UNIQUE(idTrack),
	CONSTRAINT comiteRelecture_pk PRIMARY KEY (idComite),
	CONSTRAINT ComiteTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack)
);

CREATE TABLE CoPresident
(
	idChercheur NUMBER NOT NULL,
	idComite NUMBER NOT NULL,
	CONSTRAINT copresident_pk PRIMARY KEY (idChercheur, idComite),
	CONSTRAINT chercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT CoPresComiteRelecture_fk FOREIGN KEY (idComite) REFERENCES ComiteRelecture(idComite)
);

CREATE TABLE Sujet
(
	idSujet NUMBER NOT NULL,
	motClef VARCHAR(30) NOT NULL,
	CONSTRAINT sujet_pk PRIMARY KEY (idSujet)
);

CREATE TABLE TrackASujet
(
	idTrack NUMBER NOT NULL,
	idSujet NUMBER NOT NULL,
	CONSTRAINT TrackASujet_pk PRIMARY KEY (idTrack, idSujet),
	CONSTRAINT TrackASujetTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack),
	CONSTRAINT TrackASujetSujet_fk FOREIGN KEY (idSujet) REFERENCES Sujet(idSujet)
);

CREATE TABLE Membre
(
	idComite NUMBER NOT NULL,
	idChercheur NUMBER NOT NULL,
	CONSTRAINT membre_pk PRIMARY KEY (idChercheur, idComite),
	CONSTRAINT membreChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT membreComite_fk FOREIGN KEY (idComite) REFERENCES ComiteRelecture(idComite)
);

CREATE TABLE Soumission
(
	noSoumission NUMBER NOT NULL,
	titre VARCHAR(500) NOT NULL,
	resume VARCHAR(200) NOT NULL,
	corps VARCHAR(200) NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT soumission_pk PRIMARY KEY (noSoumission),
	CONSTRAINT soumissionTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack)
);

CREATE TABLE Evaluation
(
	idComite NUMBER NOT NULL,
	idChercheur NUMBER NOT NULL,
	noSoumission NUMBER NOT NULL,
	note  NUMBER NOT NULL,
	CONSTRAINT evalution_pk PRIMARY KEY (idChercheur, noSoumission, idComite),
	CONSTRAINT evalChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT evalSoumission_fk FOREIGN KEY (noSoumission) REFERENCES Soumission(noSoumission),
	CONSTRAINT evalComiteRelecture_fk FOREIGN KEY (idComite) REFERENCES ComiteRelecture(idComite)
);

CREATE TABLE AuteurASoumission
(
	idChercheur NUMBER NOT NULL,
	idSoumission NUMBER NOT NULL,
	rang  NUMBER NOT NULL,
	CONSTRAINT AuteurASoumission_pk PRIMARY KEY (idChercheur, idSoumission),
	CONSTRAINT soumissionChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT soumission_fk FOREIGN KEY (idSoumission) REFERENCES Soumission(noSoumission)
);

-- idChercheur;insoumission,rang
INSERT INTO AuteurASoumission VALUES (1,1,1);
INSERT INTO AuteurASoumission VALUES (3,1,2);
INSERT INTO AuteurASoumission VALUES (2,2,1);
INSERT INTO AuteurASoumission VALUES (7,2,2);
INSERT INTO AuteurASoumission VALUES (11,2,3);
INSERT INTO AuteurASoumission VALUES (5,3,1);
INSERT INTO AuteurASoumission VALUES (1,3,2);
INSERT INTO AuteurASoumission VALUES (9,3,3);
INSERT INTO AuteurASoumission VALUES (10,4,1);
INSERT INTO AuteurASoumission VALUES (14,4,2);
INSERT INTO AuteurASoumission VALUES (8,5,1);
INSERT INTO AuteurASoumission VALUES (4,5,2);
INSERT INTO AuteurASoumission VALUES (6,5,3);
INSERT INTO AuteurASoumission VALUES (12,6,1);
INSERT INTO AuteurASoumission VALUES (10,7,2);
INSERT INTO AuteurASoumission VALUES (14,7,1);
INSERT INTO AuteurASoumission VALUES (15,8,1);
INSERT INTO AuteurASoumission VALUES (16,9,1);
INSERT INTO AuteurASoumission VALUES (2,9,2);
INSERT INTO AuteurASoumission VALUES (11,9,3);
INSERT INTO AuteurASoumission VALUES (14,0,1);
INSERT INTO AuteurASoumission VALUES (12,0,2);
INSERT INTO AuteurASoumission VALUES (16,1,1);
INSERT INTO AuteurASoumission VALUES (17,1,2);
INSERT INTO AuteurASoumission VALUES (22,2,1);
INSERT INTO AuteurASoumission VALUES (23,2,2);
INSERT INTO AuteurASoumission VALUES (20,3,1);
INSERT INTO AuteurASoumission VALUES (21,4,1);
INSERT INTO AuteurASoumission VALUES (23,5,1);
INSERT INTO AuteurASoumission VALUES (22,5,2);
INSERT INTO AuteurASoumission VALUES (24,6,1);
INSERT INTO AuteurASoumission VALUES (22,6,2);
INSERT INTO AuteurASoumission VALUES (18,7,1);
INSERT INTO AuteurASoumission VALUES (20,8,1);
INSERT INTO AuteurASoumission VALUES (19,8,2);
INSERT INTO AuteurASoumission VALUES (19,9,1);
INSERT INTO AuteurASoumission VALUES (21,9,2);
INSERT INTO AuteurASoumission VALUES (25,0,1);
INSERT INTO AuteurASoumission VALUES (18,0,2);
INSERT INTO AuteurASoumission VALUES (24,0,3);
INSERT INTO AuteurASoumission VALUES (15,1,1);
INSERT INTO AuteurASoumission VALUES (17,2,1);
INSERT INTO AuteurASoumission VALUES (16,2,2);
INSERT INTO AuteurASoumission VALUES (26,3,1);
INSERT INTO AuteurASoumission VALUES (16,4,1);
INSERT INTO AuteurASoumission VALUES (17,4,2);
INSERT INTO AuteurASoumission VALUES (18,4,3);


-- idChercheur,nom,prénom,adresse,courriel
INSERT INTO Chercheur VALUES (1,'Deslisle','Xavier',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (2,'Capitaine','Milène',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (3,'Wouawad','Hajdi',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (4,'Dutoit','René,SAP',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (5,'Strumpf','Helmut',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (6,'Gregoriano','Bruno',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (7,'Missoukov','Vladimir',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (8,'Nakamura','Tiropito',Sony,<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (9,'Blaassen','Wilem',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (10,'Fred','O’Henry',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (11,'Nora','Olssen',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (12,'Jeyong','Park',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (13,'Rakesh','Gupta',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (14,'Ian','Holmes',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (15,'Dolores','Cruz',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (16,'Tadeusz','Hvostovski',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (17, 'Flanagan','David',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (18, 'Nassar','Nazih',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (19,'Mario','Luigi',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (20,'Trahan','Terry',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (21,'Auberjonois','Aubin',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (22,'Jaeger','Patrick',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (23, 'Wan','Chang',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (24,'Pépin','Marsilius',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (25,'Ribeiro','Davi',<premom>.<nom>'@e-conf.org');
INSERT INTO Chercheur VALUES (26,'Davison','Katherine',<premom>.<nom>'@e-conf.org');


--idTrack,idComité,
INSERT INTO ComiteRelecture VALUES (1,11);
INSERT INTO ComiteRelecture VALUES (2,12);
INSERT INTO ComiteRelecture VALUES (3,13);
INSERT INTO ComiteRelecture VALUES (4,14);
INSERT INTO ComiteRelecture VALUES (5,15);
INSERT INTO ComiteRelecture VALUES (6,16);
INSERT INTO ComiteRelecture VALUES (7,17);
INSERT INTO ComiteRelecture VALUES (8,18);

-- titre,arbreviation,féruence,
INSERT INTO Conference VALUES (Symposium de Pataphysique Appliquée,SPA,6,);
INSERT INTO Conference VALUES (SIAM Data Mining,SDM,12);

--idComité,idChercheur
INSERT INTO CoPresident VALUES (11,1);
INSERT INTO CoPresident VALUES (11,4);
INSERT INTO CoPresident VALUES (12,2);
INSERT INTO CoPresident VALUES (12,3);
INSERT INTO CoPresident VALUES (13,3);
INSERT INTO CoPresident VALUES (13,2);
INSERT INTO CoPresident VALUES (14,8);
INSERT INTO CoPresident VALUES (14,4);
INSERT INTO CoPresident VALUES (15,16);
INSERT INTO CoPresident VALUES (15,10);
INSERT INTO CoPresident VALUES (16,6);
INSERT INTO CoPresident VALUES (16,8);
INSERT INTO CoPresident VALUES (17,7);
INSERT INTO CoPresident VALUES (17,10);
INSERT INTO CoPresident VALUES (18,8);
INSERT INTO CoPresident VALUES (18,9);

-- idÉdition,titre,lieu,début,fin
INSERT INTO Edition VALUES (1,'Symposium de Pataphysique Appliquée','Paris','11.04.2017,15'.'04.2017');
INSERT INTO Edition VALUES (2,'Symposium de Pataphysique Appliquée','New York','15.10.2017','19.10.2017');
INSERT INTO Edition VALUES (3,'SIAM Data Mining' ,'Houston','27.04.2017','29.04.2017');
INSERT INTO Edition VALUES (4,'SIAM Data Mining' ,'San Diego','03.05.2018','05.05.2018');


-- idComité,idChercheur,noSoumission,note
INSERT INTO Evaluation VALUES (11,5,1);
INSERT INTO Evaluation VALUES (11,3,2);
INSERT INTO Evaluation VALUES (11,6,3);
INSERT INTO Evaluation VALUES (12,1,4);
INSERT INTO Evaluation VALUES (12,7,5);
INSERT INTO Evaluation VALUES (12,4,6);
INSERT INTO Evaluation VALUES (13,4,7);
INSERT INTO Evaluation VALUES (13,7,8);
INSERT INTO Evaluation VALUES (13,7,9);
INSERT INTO Evaluation VALUES (14,3,10);
INSERT INTO Evaluation VALUES (14,3,11);
INSERT INTO Evaluation VALUES (14,11,12);
INSERT INTO Evaluation VALUES (15,12,13);
INSERT INTO Evaluation VALUES (15,12,14);
INSERT INTO Evaluation VALUES (15,12,15);
INSERT INTO Evaluation VALUES (16,11,16);
INSERT INTO Evaluation VALUES (16,13,17);
INSERT INTO Evaluation VALUES (16,13,18);
INSERT INTO Evaluation VALUES (17,8,19);
INSERT INTO Evaluation VALUES (17,14,20);
INSERT INTO Evaluation VALUES (17,8,21);
INSERT INTO Evaluation VALUES (18,13,22);
INSERT INTO Evaluation VALUES (18,2,23);
INSERT INTO Evaluation VALUES (18,9,24);
INSERT INTO Evaluation VALUES (11,6,1);
INSERT INTO Evaluation VALUES (11,6,2);
INSERT INTO Evaluation VALUES (12,1,5);
INSERT INTO Evaluation VALUES (13,1,7);
INSERT INTO Evaluation VALUES (13,4,8);
INSERT INTO Evaluation VALUES (14,9,10);
INSERT INTO Evaluation VALUES (15,8,13);
INSERT INTO Evaluation VALUES (16,9,16);
INSERT INTO Evaluation VALUES (17,14,19);
INSERT INTO Evaluation VALUES (17,15,20);
INSERT INTO Evaluation VALUES (17,14,21);
INSERT INTO Evaluation VALUES (18,2,24);
INSERT INTO Evaluation VALUES (17,15,19);

--idComité,idChercheur
INSERT INTO Membre VALUES (11,3)
INSERT INTO Membre VALUES (11,5)
INSERT INTO Membre VALUES (11,6)
INSERT INTO Membre VALUES (12,1);
INSERT INTO Membre VALUES (12,4);
INSERT INTO Membre VALUES (12,7);
INSERT INTO Membre VALUES (13,4);
INSERT INTO Membre VALUES (13,1);
INSERT INTO Membre VALUES (13,7);
INSERT INTO Membre VALUES (14,3);
INSERT INTO Membre VALUES (14,9);
INSERT INTO Membre VALUES (14,11);
INSERT INTO Membre VALUES (15,12);
INSERT INTO Membre VALUES (15,8);
INSERT INTO Membre VALUES (15,14);
INSERT INTO Membre VALUES (16,13);
INSERT INTO Membre VALUES (16,11);
INSERT INTO Membre VALUES (16,9);
INSERT INTO Membre VALUES (17,8);
INSERT INTO Membre VALUES (17,14);
INSERT INTO Membre VALUES (17,15);
INSERT INTO Membre VALUES (18,13);
INSERT INTO Membre VALUES (18,9);
INSERT INTO Membre VALUES (18,2);


-- noSoumission,titre,résumé,corps, d'apres le schéma i lfaut mettre des IDTRACK
INSERT INTO Soumission VALUES (1,'La pataphysique homéopathique et ses bienfaits connus','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (2,'L’approche systémique en pataphysiologie','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (3,'Revue critique des théories pataphydiques en épidémiologie','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (4,'Enseignement de la pataphysique au primaire','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (5,'Vers une nouvelle didactique de la pataphysique','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (6,'Comparaison des cours de pataphysique et de psychanalyse','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (7,'Education et pataphysique : un nouveau contrat social','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (8,'Pataphysique : science, philosophie et escroquerie','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (9,'Pate-à-sel et pataphysique : construire l enseignement du futur','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (10,'Vers des outils pataphysiques adaptés : un état de l art','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (11,'Le calendrier pataphysique, une approche holistique ','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (12,'Des outils imaginaires pour des solutions imaginaires','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (13,'NewSQL : une approche relationelle solide pour une analyse de graphes robuste','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (14,'Book embedding, réduction des espaces de recherche dans l analyse de graphes complexes','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (15,'Fonctions noyaux de graphes : extraction de caracteristiques dans des espaces infinis','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (16,'Deep learning : une composition de problèmes convexes et ses solutions alternatives','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (17,'L influence des modèles distribués sur les langages de programmation','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (18,'Cryptage à faible consommation d énergie pour les table de partition dans les architectures distribueés','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (19,'De l exploration des arbres suffixes','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (20,'Émulation de la tolérance aux pannes byzantines et des protocoles','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (21,'Analyse de la vérification du modèle et de la redondance','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (22,'Abyss : la singularité, une question de couches ?','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (23,'L influence de la théorie aléatoire sur l ingénierie du logiciel d autoapprentissage','bla-bla','tiny.url',IDTRACK);
INSERT INTO Soumission VALUES (24,'Un cas pour la loi de Moore','bla-bla','tiny.url',IDTRACK);

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

-- idTrack,idÉdition,titre,description,nbMaxPapiers,nbMaxPapiers
INSERT INTO Track VALUES (1,1,'Biomedical','Applications biomédicales de la pataphysique',2,6);
INSERT INTO Track VALUES (2,1,'Didactique','Didactique de la pataphysique',2,6);
INSERT INTO Track VALUES (3,2,'Didactique','Didactique avancée de la pataphysique',2,6);
INSERT INTO Track VALUES (4,2,'Informatique','Informatisation des outils pataphysiques',2,6);
INSERT INTO Track VALUES (5,3,'Graph Mining','Mining complex graphs',2,4);
INSERT INTO Track VALUES (6,3,'Deep Learning','Classification in the deep',2,4);
INSERT INTO Track VALUES (7,3,'Graph Mining','Mining heterogeneous networks',2,4);
INSERT INTO Track VALUES (8,3,'Deep Learning','Classification the very deep',2,4);

