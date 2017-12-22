set echo on;
set serveroutput on;

-- Trigger lance avant insertion et update sur la table CoPresident
create or replace trigger MaxCoPresidentComite
before insert or update on CoPresident
for each row
DECLARE
compte number;
BEGIN
  select count(idChercheur) into compte from CoPresident where idComiteRelecture = :new.idComiteRelecture;

  if( compte = 2 )THEN
    RAISE_APPLICATION_ERROR(-20001,'Maximum de Deux co-presidents par track');
  end if;
end;
/

-- Contrainte Co-president et auteur incompatible pour un meme track
CREATE OR REPLACE TRIGGER CoPresAuteurNonCompatCoPrez
	before INSERT OR UPDATE ON CoPresident
  FOR EACH ROW
  declare t_count number;
  BEGIN
  select count(*) into t_count
  from AuteurASoumission aas
  join Soumission sou on aas.idSoumission = sou.noSoumission
  join ComiteRelecture cr on sou.idTrack = cr.idTrack
  where aas.idChercheur = :new.idChercheur and cr.idComiteRelecture = :new.idComiteRelecture;
  IF( t_count > 0 ) THEN
    raise_application_error( -20001, 'Un CoPresident ne peut pas avoir soumis sur le track qu''il administre');
  end if;
  end;
/

create or replace trigger CoPresAuteurNonCompatAuteur
after insert or update on AuteurASoumission
FOR EACH ROW
  declare t_count number;
  BEGIN
  select count(*) into t_count
  from CoPresident cop
  join ComiteRelecture cr on cop.idComiteRelecture = cr.idComiteRelecture
  join Soumission sou on cr.idTrack = sou.idTrack
  where cop.idChercheur = :new.idChercheur and sou.noSoumission = :new.idSoumission;
  if( t_count > 0 ) then
    raise_application_error(-20003, 'Impossible d''avoir un Auteur qui fait une soumission sur un track ou il est CoPresident');
  end if;
end;
/

-- Contrainte de maximum de soumission par Membre d'un comite de relecture

create or replace trigger MaxEvaluationParMembre
before insert or update on Evaluation
FOR EACH ROW
  declare t_count number;
  BEGIN
  select count(*) into t_count
  from evaluation
  where idChercheur = :new.idChercheur and idComiteRelecture = :new.idComiteRelecture;
  if (t_count >= 3) THEN
    raise_application_error(-20005,'Maximum de soumissions pour un evaluateur deja atteint pour ce track');
  end if;
end;
/

-- Trigger lance apres supresssion dans la table Soumission
CREATE OR REPLACE TRIGGER RetraitSansSoucis
	BEFORE DELETE ON Soumission
	FOR EACH ROW

	BEGIN
	  DELETE FROM AuteurASoumission where idSoumission = :old.noSoumission;
		DELETE FROM Evaluation where noSoumission = :old.noSoumission;
	END;
/

-- Contrainte de Evaluateur ne peut evaluer un co auteur
create or replace trigger ConflitInteretEvaluation
after insert or update on Evaluation
for each row
declare t_count number;
BEGIN
  select count(*) into t_count
  from  AuteurASoumission aas
  join AuteurASoumission aas2 on aas.idChercheur = aas2.idChercheur
  join AuteurASoumission aas3 on aas2.idSoumission = aas3.idSoumission
  where aas.idSoumission = :new.noSoumission and aas3.idChercheur = :new.idChercheur;

  if (t_count > 0) THEN
    raise_application_error(-20005,'Conflit d''interet, evaluateur a deja travailler avec un des auteur de cette soumission');
  end if;
end;
/

create or replace trigger ConflitInteretAuteur
before insert or update on AuteurASoumission
for each row
declare t_count number;
BEGIN
  select count(*) into t_count
  from  AuteurASoumission aa
    join Evaluation eval on aa.idSoumission = eval.noSoumission
    join AuteurASoumission aas on eval.idChercheur = aas.idChercheur
    join AuteurASoumission aas2 on aas.idChercheur = aas2.idChercheur
    join AuteurASoumission aas3 on aas2.idSoumission = aas3.idSoumission
  where aa.idSoumission = :new.idSoumission and aas3.idChercheur = :new.idChercheur;

  if (t_count > 0) THEN
    raise_application_error(-20005,'Conflit d''interet, l''evaluateur de la soumission a deja travailler avec l''auteur nouvellement ajoute');
  end if;
end;
/
