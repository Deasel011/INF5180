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
	nbMinPapiers NUMBER NOT NULL,
	nbMaxPapiers NUMBER NOT NULL,
	description VARCHAR (100) NOT NULL,
	CONSTRAINT track_id PRIMARY KEY (idTrack),
	CONSTRAINT trackEdition_fk FOREIGN KEY (idEdition) REFERENCES Edition(idEdition),
	CONSTRAINT nbPapiers_check CHECK (nbMinPapiers <= nbMaxPapiers)
);

CREATE TABLE Chercheur
(
	idChercheur NUMBER NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	nom VARCHAR(20) NOT NULL,
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
	idChercheur NUMBER NOT NULL,
	idComite NUMBER NOT NULL,
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
	idChercheur NUMBER NOT NULL,
	noSoumission NUMBER NOT NULL,
	idComite NUMBER NOT NULL,
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