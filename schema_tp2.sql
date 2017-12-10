 -- noinspection SqlDialectInspectionForFile

-- noinspection SqlNoDataSourceInspectionForFile

set echo on;
set serveroutput on;

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
	nbPapiersMin NUMBER NOT NULL,
	nbPapiersMax NUMBER NOT NULL,
	CONSTRAINT track_id PRIMARY KEY (idTrack),
	CONSTRAINT trackEdition_fk FOREIGN KEY (idEdition) REFERENCES Edition(idEdition),
	CONSTRAINT nbPapiers_check CHECK (nbPapiersMin <= nbPapiersMax)
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
  idSujet int not null,
	motClef VARCHAR(30) NOT NULL,
	CONSTRAINT sujet_pk PRIMARY KEY (idSujet),
	CONSTRAINT sujet_bk UNIQUE (motClef)
);

CREATE TABLE TrackASujet
(
	idTrack NUMBER NOT NULL,
	motClef VARCHAR(30) NOT NULL,
	CONSTRAINT TrackASujet_pk PRIMARY KEY (idTrack, motClef),
	CONSTRAINT TrackASujetTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack),
	CONSTRAINT TrackASujetSujet_fk FOREIGN KEY (motClef) REFERENCES Sujet(motClef)
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
	titre VARCHAR(50) NOT NULL,
	resume VARCHAR(200) NOT NULL,
	corps BLOB NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT soumission_pk PRIMARY KEY (noSoumission),
	CONSTRAINT soumissionTrack_fk FOREIGN KEY (idTrack) REFERENCES Track(idTrack)
);

CREATE TABLE Evaluation
(
	idChercheur NUMBER NOT NULL,
	noSoumission NUMBER NOT NULL,
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT evalution_pk PRIMARY KEY (idChercheur, noSoumission, idComiteRelecture),
	CONSTRAINT evalChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT evalSoumission_fk FOREIGN KEY (noSoumission) REFERENCES Soumission(noSoumission),
	CONSTRAINT evalComiteRelecture_fk FOREIGN KEY (idComiteRelecture) REFERENCES ComiteRelecture(idComiteRelecture)
);

CREATE TABLE AuteurASoumission
(
	idChercheur NUMBER NOT NULL,
	idSoumission NUMBER NOT NULL,
	CONSTRAINT AuteurASoumission_pk PRIMARY KEY (idChercheur, idSoumission),
	CONSTRAINT soumissionChercheur_fk FOREIGN KEY (idChercheur) REFERENCES Chercheur(idChercheur),
	CONSTRAINT soumission_fk FOREIGN KEY (idSoumission) REFERENCES Soumission(noSoumission)
);
