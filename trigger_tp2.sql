set echo on;
set serveroutput on;

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

CREATE OR REPLACE TRIGGER CheckNbEvaluation
	BEFORE INSERT OR UPDATE ON Evaluation
		FOR EACH ROW

	DECLARE
	t_count NUMBER;

	BEGIN
		SELECT COUNT(noSoumission) INTO t_count	 
		FROM Evaluation
		Where idChercheur = :new.idChercheur;

		IF( t_count > 3 ) THEN
			RAISE_APPLICATION_ERROR( -20002, 'Pas plus de trois evaluation par membre');
		END IF;
	END;

/

CREATE OR REPLACE TRIGGER CheckConflitCoPresAuteur
	BEFORE INSERT OR UPDATE ON CoPresident
		FOR EACH ROW

	DECLARE
	t_idTrackCoPres INTEGER;
	t_idTrackAuteur INTEGER;

	BEGIN
		SELECT idTrack INTO t_idTrackCoPres
		FROM CoPresident cp 
			INNER JOIN Comiterelecture cr 
			ON cp.idComiteRelecture = cr.idComiteRelecture
		WHERE idChercheur = :new.idChercheur;

		SELECT COUNT(idTrack) INTO t_idTrackAuteur
		FROM AuteurASoumission aas
			INNER JOIN Soumission s
			ON aas.idSoumission = s.noSoumission
		WHERE idChercheur = :new.idChercheur
		AND idTrack = t_idTrackCoPres;

		IF( t_idTrackAuteur > 0 ) THEN
			RAISE_APPLICATION_ERROR( -20003, 'Un co-president ne peut etre auteur d une soumission dans son propre track');
		END IF;

	END;
/

CREATE OR REPLACE TRIGGER CheckConflitAuteurCoPres
	BEFORE INSERT OR UPDATE ON AuteurASoumission
	FOR EACH ROW

	DECLARE
	t_idTrackSoumission INTEGER;
	t_count INTEGER;

	BEGIN
		SELECT idTrack into t_idTrackSoumission
		FROM Soumission s
			INNER JOIN AuteurASoumission aas
			ON s.noSoumission = aas.idSoumission 
		WHERE idChercheur = :new.idChercheur;

		SELECT COUNT (idTrack) INTO t_count 
		FROM ComiteRelecture cr
			INNER JOIN CoPresident cp
			ON cr.idComiteRelecture = cp.idComiteRelecture
		WHERE idChercheur = :new.idChercheur and cp.idTrack = t_idTrackSoumission;
		
		IF( t_count > 0 ) THEN
			RAISE_APPLICATION_ERROR( -20003, 'Un co-president ne peut etre auteur d une soumission dans son propre track');
		END IF;

	END;
/

CREATE OR REPLACE TRIGGER RetraitSansSoucis
	AFTER DELETE ON Soumission
	FOR EACH ROW

	BEGIN
		DELETE FROM Evaluation where noSoumission = :old.noSoumission;
		DELETE FROM AuteurASoumission where idSoumission = :old.noSoumission;
		DELETE FROM Track where idTrack = :old.idTrack;
	END;
/

CREATE OR REPLACE TRIGGER PasDeConflitDinteret
	BEFORE INSERT OR UPDATE ON Evaluation
	FOR EACH ROW

	DECLARE
	t_count INTEGER;

	BEGIN
		for i in (select idSoumission from AuteurASoumission aas where aas.idChercheur = :new.idChercheur) loop
			for j in (select idChercheur from AuteurASoumission aas where aas.idSoumission = i.idSoumission) loop
				select count(idSoumission) into t_count 
				from AuteurASoumission aas 
				where aas.idChercheur = j.idChercheur 
				and aas.idSoumission in (select idSoumission from Evaluation e where e.idChercheur = :new.idChercheur);
				
				if t_count > 0 then
					RAISE_APPLICATION_ERROR( -20010, 'Un evaluateur ne peut evaluer la soumission d un co-auteur');
				end if;
			end loop;
		end loop;
	END;
/


CREATE OR REPLACE TRIGGER PasDeConflitDinteretAAS
	BEFORE INSERT OR UPDATE ON AuteurASoumission
	FOR EACH ROW
	
	DECLARE
	t_count integer;

	BEGIN
		for i in (select idSoumission from AuteurASoumission where idChercheur = :new.idChercheur) loop			
			for j in (select idChercheur from AuteurASoumission aas where aas.idSoumission = i.idSoumission) loop
				select count(idChercheur) into t_count from Evaluation e where e.idSoumission = :new.idSoumission
				and e.idChercheur = j.idChercheur;

				if t_count > 0 then
					RAISE_APPLICATION_ERROR( -20010, 'Un evaluateur ne peut evaluer la soumission d un co-auteur');
				end if;
			end loop;
		end loop;
	END;

/

if exists (
select 1 from Evaluation eval
left join Soumission soum on eval.noSoumission = soum.nosoumission
left join AuteurASoumission aas on soum.noSoumission = aas.idSoumission
left join AuteurASoumission aas2 on aas2.idChercheur = aas.idChercheur
left join AuteurASoumission aas3 on aas2.idSoumission = aas3.idSoumission
where eval.idChercheur = aas.idChercheur or eval.idChercheur = aas3.idChercheur
)
raise_application_error(-10000,'Conflit dindeter...')
