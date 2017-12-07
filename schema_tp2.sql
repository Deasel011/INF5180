CREATE TABLE Conference
(
	titre VARACHAR(50) NOT NULL,
	acronyme VARCHAR(10) NOT NULL,
	frequence INTEGER() NOT NULL,
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
	CONSTRAINT edition_pk PRIMARY KEY (idEdition)
	CONSTRAINT editiionConference_fk FOREIGN KEY (titre)
		REFERENCE Conference(titre),
	CONSTRAINT date_check CHECK (dateDebut <= dateFin)
);

CREATE TABLE Track
(
	idTrack NUMBER  NOT NULL,
	idEdition NUMBER NOT NULL,
	titre VARCHAR(50) NOT NULL, 
	nbPapiersMin NUMBER NOT NULL,
	nbPapiersMax NUMBER NOT NULL,
	CONSTRAINT track_id PRIMARY KEY (idTrack),
	CONSTRAINT trackEdition_fk FOREIGN KEY (idEdition)à
		REFERENCE Edition(idEdition)
	CONSTRAINT nbPapiers_check CHECK (nbPapiersMin < nbPapiersMax)

);

CREATE TABLE CoPresident
(
	idChercheur NUMBER NOT NULL,
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT copresident_pk PRIMARY KEY (idChercheur, idComiteRelecture),
	CONSTRAINT chercheur_fk FOREIGN KEY (idChercheur)
		REFERENCE Chercheur(idChercheur)
	CONSTRAINT CoPresComiteRelecture_fk FOREIGN KEY (idComiteRelecture)
		REFERENCE Comiterelecture(idComiteRelecture)
);

CREATE TABLE ComiteRelecture
(
	idComiteRelecture NUMBER NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT idTrack_unique UNIQUE(idTrack),
	CONSTRAINT comiteRelecture_pk PRIMARY KEY (idComiteRelecture),
	CONSTRAINT ComiteTrack_fk FOREIGN KEY (idTrack)
		REFERENCE Track(idTrack)
);

CREATE TABLE TrackASujet
(
	idTrack NUMBER NOT NULL,
	motClef VARCHAR(30) NOT NULL,
	CONSTRAINT TrackASujet_pk PRIMARY KEY (idTrack, motClef),
	CONSTRAINT TrackASujetTrack_fk FOREIGN KEY (idTrack)
		REFERENCE Track(idTrack)
	CONSTRAINT TrackASujetS	ujet_fk FOREIGN KEY (motClef)
		REFERENCE Sujet(motClef)
);

CREATE TABLE Membre
(
	idChercheur NUMBER NOT NULL,
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT membre_pk PRIMARY KEY (idChercheur, idComiteRelecture),
	CONSTRAINT membreChercheur_fk FOREIGN KEY (idChercheur)
		REFERENCE Chercheur(idChercheur)
	CONSTRAINT membreComite_fk FOREIGN KEY (idComiteRelecture)
		REFERENCE ComiteRelecture(idComiteRelecture)
);

CREATE TABLE Soumission
(
	noSoumission NUMBER NOT NULL,
	titre VARCHAR(50) NOT NULL,
	resume VARCHAR(200) NOT NULL,
	corps BLOB NOT NULL,
	idTrack NUMBER NOT NULL,
	CONSTRAINT soumission_pk PRIMARY KEY (noSoumission),
	CONSTRAINT soumissionTrack_fk FOREIGN KEY (idTrack)
		REFERENCE Track(idTrack)

);

CREATE TABLE Chercheur
(
	idChercheur NUMBER NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	nom VARCHAR(20) NOT NULL,
	adresse VARCHAR(50) NOT NULL,
	CONSTRAINT chercheur_pk PRIMARY KEY (idChercheur)
);

CREATE TABLE Evaluation
(
	idChercheur NUMBER NOT NULL,
	idSoumission NUMBER NOT NULL,
	idComiteRelecture NUMBER NOT NULL,
	CONSTRAINT evalution_pk PRIMARY KEY (idChercheur, idSoumission, idComiteRelecture),
	CONSTRAINT evalChercheur_fk FOREIGN KEY (idChercheur)
		REFERENCE Chercheur(idChercheur)
	CONSTRAINT evalSoumission_fk FOREIGN KEY (idSoumission)
		REFERENCE Soumission(idSoumission)
	CONSTRAINT evalComiteRelecture_fk FOREIGN KEY (idComiteRelecture)
		REFERENCE ComiteRelecture(idComiteRelecture)
);

CREATE TABLE AuteurASoumission
(
	idChercheur NUMBER NOT NULL,
	idSoumission NUMBER NOT NULL,
	CONSTRAINT AuteurASoumission_pk PRIMARY KEY (idChercheur, idSoumission),
	CONSTRAINT soumissionChercheur_fk FOREIGN KEY (idChercheur)
		REFERENCE Chercheur(idChercheur)
	CONSTRAINT soumission_fk FOREIGN KEY (idSoumission)
		REFERENCE Soumission(idSoumission)
);

CREATE TABLE Sujet
(
	motClef VARCHAR(30) NOT NULL,
	CONSTRAINT sujet_pk PRIMARY KEY (motClef),
);


CREATE OR REPLACE TRIGGER CheckNbCoPresidentCommite
	BEFORE INSERT OR UPDATE ON CoPresident
		FOR EACH ROW

	DECLARE
	t_count NUMBER;
	t_coPresident_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_coPresident_exception, -20001)

	BEGIN
		SELECT COUNT(idChercheur) INTO t_count	 
		FROM CoPresident
		Where idComiteRelecture = :new.idComiteRelecture

		IF( t_count > 2 ) THEN
			RAISE_APPLICATION_ERROR( -20001, "Pas plus de deux co-president pour un meme track")
		END IF;

		EXCEPTION
			WHEN t_coPresident_exception
			THEN dbms_output.put_line( sqlerrm );
	END;


CREATE OR REPLACE TRIGGER CheckNbEvaluation
	BEFORE INSERT OR UPDATE ON Evaluation
		FOR EACH ROW

	DECLARE
	t_count NUMBER;
	t_nbEval_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_nbEval_exception, -20002)

	BEGIN
		SELECT COUNT(noSoumission) INTO t_count	 
		FROM Evaluation
		Where idChercheur = :new.idChercheur

		IF( t_count > 3 ) THEN
			RAISE_APPLICATION_ERROR( -20002, "Pas plus de trois evaluation par membre")
		END IF;

		EXCEPTION
			WHEN t_nbEval_exception
			THEN dbms_output.put_line( sqlerrm );
	END;


CREATE OR REPLACE TRIGGER CheckConflitCoPresAuteur
	BEFORE INSERT OR UPDATE 
	ON (CoPresident cp JOIN AuteurASoumission aas
		ON cp.idChercheur = aas.idChercheur) 
		FOR EACH ROW

	DECLARE
	t_count NUMBER;
	t_conflit_coPres_soumission_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_conflit_coPres_soumission_exception, -20003)

	BEGIN
		SELECT COUNT(idTrack) INTO t_count	 
		FROM CoPresident cp
			INNER JOIN Comiterelecture cr
				ON cp.idComiteRelecture = cr.idComiteRelecture
			INNER JOIN AuteurASoumission aas
				ON cp.idChercheur = aas.idChercheur
			INNER JOIN Soumission s
				ON aas.idSoumission = s.noSoumission 
		Where idTrack = :new.idTrack

		IF( t_count > 0 ) THEN
			RAISE_APPLICATION_ERROR( -20003, "Un co-president ne peut etre auteur d'une soumission dans son propre track")
		END IF;

		EXCEPTION
			WHEN t_conflit_coPres_soumission_exception
			THEN dbms_output.put_line( sqlerrm );
	END;


