/*Au plus 2 co-president par comite de relecture*/
create or replace trigger MaxCoPresidentComite
after insert or update on CoPresident
for each row
DECLARE
compte number;
BEGIN
  select count(idChercheur) into compte from CoPresident where idComiteRelecture = :new.idComiteRelecture;

  if compte > 2 THEN
    RAISE_APPLICATION_ERROR(-20001,'Maximum de Deux co-presidents par track');
  end if;
end;
/

/*Au plus 3 evaluations par membre de comite*/
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
/

/*Co-president de comite et Auteur de soumission sont incompatible pour le meme track
  Trigger qui verifie les insertion/update sur CoPresident*/
CREATE OR REPLACE TRIGGER CheckConflitCoPresAuteur
	BEFORE INSERT OR UPDATE ON CoPresident
		FOR EACH ROW

	DECLARE
	t_idTrackCoPres INTEGER;
	t_idTrackAuteur INTEGER;
	t_conflit_coPres_soumission_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_conflit_coPres_soumission_exception, -20003)

	BEGIN
		SELECT idTrack INTO t_idTrackCoPres
		FROM CoPresident cp 
			INNER JOIN Comiterelecture cr 
			ON cp.idComiteRelecture = cr.idComiteRelecture
		WHERE idChercheur = :new.idChercheur

		SELECT COUNT(idTrack) INTO t_idTrackAuteur
		FROM AuteurASoumission aas
			INNER JOIN Soumission s
			ON aas.idSoumission = s.noSoumission
		WHERE idChercheur = :new.idChercheur
		AND idTrack = t_idTrackCoPres

		IF( t_count > 0 ) THEN
			RAISE_APPLICATION_ERROR( -20003, "Un co-president ne peut etre auteur d'une soumission dans son propre track")
		END IF;

		EXCEPTION
			WHEN t_conflit_coPres_soumission_exception
			THEN dbms_output.put_line( sqlerrm );
	END;
/

/*Co-president de comite et Auteur de soumission sont incompatible pour le meme track
  Trigger qui verifie les insertion/update sur AuteurASoumission*/
CREATE OR REPLACE TRIGGER CheckConflitAuteurCoPres
	BEFORE INSERT OR UPDATE ON AuteurASoumission
	FOR EACH ROW

	DECLARE
	t_idTrackSoumission INTEGER;
	t_count INTEGER;
	t_conflit_coPres_soumission_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_conflit_coPres_soumission_exception, -20003)

	BEGIN
		SELECT idTrack into t_idTrackSoumission
		FROM Soumission s
			INNER JOIN AuteurASoumission aas
			ON s.noSoumission = aas.idSoumission 
		WHERE idChercheur = :new.idChercheur

		SELECT COUNT (idTrack) INTO t_count 
		FROM ComiteRelecture cr
			INNER JOIN CoPresident cp
			ON cr.idComiteRelecture = cp.idComiteRelecture
		WHERE idChercheur = :new.idChercheur
		
		IF( t_count > 0 ) THEN
			RAISE_APPLICATION_ERROR( -20003, "Un co-president ne peut etre auteur d'une soumission dans son propre track")
		END IF;

		EXCEPTION
			WHEN t_conflit_coPres_soumission_exception
			THEN dbms_output.put_line( sqlerrm );
	END;
/

/*La suppression d'une soumission entraine la suppression de toutes ses affectations et tous ses roles d'auteur*/
CREATE OR REPLACE TRIGGER RetraitSansSoucis
	AFTER DELETE ON Soumission
	FOR EACH ROW

	BEGIN
		DELETE FROM Evaluation e where e.idSoumission = :old.noSoumission
		DELETE FROM AuteurASoumission aas where aas.idSoumission = :old.noSoumission
		DELETE FROM Track t where t.track = :old.idTrack
	END;
/

/*Aucun membre de comite n'evalue l'article d'un co-auteur*/
CREATE OR REPLACE TRIGGER PasDeConflitDinteret
	BEFORE INSERT OR UPDATE ON Evaluation
	FOR EACH ROW

	DECLARE
	t_soumission INTEGER;
	t_coAuteur INTEGER;
	t_conflit_interet_exception EXCEPTION;
	PRAGMA EXCEPTION_INIT(t_conflit_interet_exception, -20004)

	BEGIN
		FOR row IN 
			(SELECT idSoumission 
			 FROM AuteurASoumission 
			 WHERE e.idChercheur = :new.idChercheur) LOOP
			SELECT COUNT(idChercheur) INTO t_coAuteur
			FROM AuteurASoumission
				INNER JOIN Soumission s ON s.noSoumission = aas.idSoumission
				INNER JOIN Evaluation e ON s.noSoumission = e.noSoumission
			WHERE idSoumission = row.idSoumission
			AND

			IF( t_coAuteur > 0 ) THEN
				RAISE_APPLICATION_ERROR( -20004, "Un evaluateur ne peut evaluer la soumission d'un co-auteur")
			END IF;

		END LOOP;
		EXCEPTION
			WHEN t_conflit_coPres_soumission_exception
			THEN dbms_output.put_line( sqlerrm );
	END;
/
