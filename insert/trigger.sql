set echo on;
set serveroutput on;

-- Trigger lance avant insertion et update sur la table CoPresident
create or replace trigger MaxCoPresidentComite
before insert or update on CoPresident
for each row
DECLARE
compte number;
BEGIN
  select count(idChercheur) into compte from CoPresident where idComite = :new.idComite;

  if compte = 2 THEN
    RAISE_APPLICATION_ERROR(-20001,'Maximum de Deux co-presidents par track');
  end if;
end;
/

-- Trigger lance avant insertion et update sur la table Evaluation
CREATE OR REPLACE TRIGGER CheckNbEvaluation
	BEFORE INSERT OR UPDATE ON Evaluation
		FOR EACH ROW

	DECLARE
	t_count NUMBER;

	BEGIN
		SELECT COUNT(noSoumission) INTO t_count	 
		FROM Evaluation
		Where idChercheur = :new.idChercheur;

		IF( t_count = 3 ) THEN
			RAISE_APPLICATION_ERROR( -20002, 'Pas plus de trois evaluation par membre');
		END IF;
	END;

/

-- Trigger lance avant insertion et update sur la table CoPresident
CREATE OR REPLACE TRIGGER CheckConflitCoPresAuteur
	BEFORE INSERT OR UPDATE ON CoPresident
		FOR EACH ROW

	DECLARE
	t_idTrackAuteur INTEGER;

	BEGIN
			dbms_output.put_line('start CheckConflitCoPresAuteur sur CoPresident idChercheur: ' || :new.idChercheur);

		SELECT count(idChercheur) into t_idTrackAuteur
		from AuteurASoumission aas
		inner join soumission s on aas.idsoumission = s.nosoumission
		WHERE aas.idChercheur = :new.idChercheur 		
		and s.idTrack = (select idTrack 
				from Comiterelecture cr 	
				where cr.idComite = :new.idcomite);

		IF( t_idTrackAuteur > 0 ) THEN
			dbms_output.put_line(t_idTrackAuteur);
			RAISE_APPLICATION_ERROR( -20003, 'Un co-president ne peut etre auteur d une soumission dans son propre track');
		END IF;

	END;
/

-- Trigger lance avant insertion et update sur la table AuteurASoumission
CREATE OR REPLACE TRIGGER CheckConflitAuteurCoPres
	BEFORE INSERT OR UPDATE ON AuteurASoumission
	FOR EACH ROW

	DECLARE
	t_idTrackAuteur INTEGER;

	BEGIN

		SELECT COUNT(idChercheur) INTO t_idTrackAuteur
		FROM CoPresident cp
		INNER JOIN comiterelecture cr
		ON cp.idcomite = cr.idcomite
		WHERE idChercheur = :new.idChercheur
		AND cr.idTrack = (select idtrack from soumission where nosoumission = :new.idsoumission);

			IF( t_idTrackAuteur > 0 ) THEN

				RAISE_APPLICATION_ERROR( -20004, 'Un co-president ne peut etre auteur d une soumission dans son propre track');
			END IF;

	END;
/

-- Trigger lance apres supresssion dans la table Soumission
CREATE OR REPLACE TRIGGER RetraitSansSoucis
	AFTER DELETE ON Soumission
	FOR EACH ROW

	BEGIN
		DELETE FROM Evaluation where noSoumission = :old.noSoumission;
		DELETE FROM AuteurASoumission where idSoumission = :old.noSoumission;
		DELETE FROM Track where idTrack = :old.idTrack;
	END;
/

-- Trigger lance avant insertion et update sur la table Evaluation
CREATE OR REPLACE TRIGGER PasDeConflitDinteret
	BEFORE INSERT OR UPDATE ON Evaluation
	FOR EACH ROW

	DECLARE
	t_count INTEGER;

	BEGIN
		for i in (select distinct aas.idChercheur from AuteurASoumission aas 
			inner join soumission s on s.nosoumission = aas.idsoumission
			inner join evaluation e on e.nosoumission = s.nosoumission
			where aas.idChercheur <> :new.idChercheur
			and aas.idsoumission in
				(select idsoumission
				 from auteurasoumission
				 where idchercheur = :new.idchercheur)) loop
		select count(noSoumission) into t_count 
		from evaluation e 
		where e.idchercheur = i.idChercheur;
			
			if t_count > 0 then
				RAISE_APPLICATION_ERROR( -20005, 'Un evaluateur ne peut evaluer la soumission d un co-auteur');
			end if;
		end loop;
	END;
/

-- Trigger lance avant insertion et update sur la table AuteurASoumission
--CREATE OR REPLACE TRIGGER PasDeConflitDinteretAAS
--	BEFORE INSERT OR UPDATE ON AuteurASoumission
--	FOR EACH ROW
--	
--	DECLARE
--	t_count integer;
--
--	BEGIN
--		for i in (select idSoumission from AuteurASoumission where idChercheur = :new.idChercheur) loop			
--			for j in (select idChercheur from AuteurASoumission aas where aas.idSoumission = i.idSoumission) loop
--				select count(idChercheur) into t_count from Evaluation e where e.noSoumission = :new.idSoumission
--				and e.idChercheur = j.idChercheur
--				and e.idChercheur <> :new.idChercheur;
--
--				if t_count > 0 then
--					RAISE_APPLICATION_ERROR( -20006, 'Un evaluateur ne peut evaluer la soumission d un co-auteur');
--				end if;
--			end loop;
--		end loop;
--	END;
--
--/
