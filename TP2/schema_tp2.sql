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
	description VARCHAR(400) NULL,
	nbPapiersMin INTEGER NOT NULL,
	nbPapiersMax INTEGER NOT NULL,
	CONSTRAINT track_id PRIMARY KEY (idTrack),
	CONSTRAINT trackEdition_fk FOREIGN KEY (idEdition) REFERENCES Edition(idEdition),
	CONSTRAINT nbPapiers_check CHECK (nbPapiersMin <= nbPapiersMax)
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
	idComiteRelecture NUMBER NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT idTrack_unique UNIQUE(idTrack),
	CONSTRAINT comiteRelecture_pk PRIMARY KEY (idComiteRelecture),
	CONSTRAINT ComiteTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack)
);

CREATE TABLE CoPresident
(
	idChercheur NUMBER NOT NULL,
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT copresident_pk PRIMARY KEY (idChercheur, idComiteRelecture),
	CONSTRAINT chercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT CoPresComiteRelecture_fk FOREIGN KEY (idComiteRelecture) REFERENCES ComiteRelecture(idComiteRelecture)
);

CREATE TABLE Sujet
(
  idSujet number not null,
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
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT membre_pk PRIMARY KEY (idChercheur, idComiteRelecture),
	CONSTRAINT membreChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT membreComite_fk FOREIGN KEY (idComiteRelecture) REFERENCES ComiteRelecture(idComiteRelecture)
);

CREATE TABLE Soumission
(
	noSoumission NUMBER NOT NULL,
	titre VARCHAR(150) NOT NULL,
	resume VARCHAR(1500) NOT NULL,
	corps VARCHAR(4000) NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT soumission_pk PRIMARY KEY (noSoumission),
	CONSTRAINT soumissionTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack)
);

CREATE TABLE Evaluation
(
	idComiteRelecture NUMBER NOT NULL,
	idChercheur NUMBER NOT NULL,
	noSoumission NUMBER NOT NULL,
	note  NUMBER NULL,
	CONSTRAINT evalution_pk PRIMARY KEY (idChercheur, noSoumission, idComiteRelecture),
	CONSTRAINT evalChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT evalSoumission_fk FOREIGN KEY (noSoumission) REFERENCES Soumission(noSoumission),
	CONSTRAINT evalComiteRelecture_fk FOREIGN KEY (idComiteRelecture) REFERENCES ComiteRelecture(idComiteRelecture)
);

CREATE TABLE AuteurASoumission
(
	idChercheur NUMBER NOT NULL,
	idSoumission NUMBER NOT NULL,
	rangAuteur NUMBER NOT NULL,
	CONSTRAINT AuteurASoumission_pk PRIMARY KEY (idChercheur, idSoumission),
	CONSTRAINT soumissionChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT soumission_fk FOREIGN KEY (idSoumission) REFERENCES Soumission(noSoumission)
);


