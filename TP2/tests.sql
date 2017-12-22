-- Test 3ieme copresident pour un comite
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (16,24);
-- DOIT LANCER UNE EXCEPTION

-- Test une 4ieme evaluation pour un membre
INSERT INTO Evaluation (idComiteRelecture, idChercheur, noSoumission) VALUES (14,7,4);
-- DOIT LANCER UNE EXCEPTION

-- Test un CoPresident qui a soumis dans son track
INSERT INTO CoPresident (idComiteRelecture, idChercheur) VALUES (19,1);
-- DOIT LANCER UNE EXCEPTION

-- Test un Auteur qui soumet sur un track ou il est copresident
insert into AuteurASoumission values(1,5,1);
-- DOIT LANCER UNE EXCEPTION

-- Test quatre soumission a evaluer pour un seul membre
insert into evaluation (idComiteRelecture, idChercheur, noSoumission) values(14,9,1);
insert into evaluation (idComiteRelecture, idChercheur, noSoumission) values(14,9,2);
-- DOIT LANCER UNE EXCEPTION

-- Test edition qui fini avant de commencer
INSERT INTO Edition VALUES (5,'SIAM Data Mining' ,'San Diego','03.05.2018','05.05.2017');
-- DOIT LANCER UNE EXCEPTION

-- Test minimum de papiers plus petit que le maximum
INSERT INTO Track VALUES (10,1,'TEST','TEST',4,2);
-- DOIT LANCER UNE EXCEPTION

-- Test De Suppression
DELETE FROM Soumission where noSoumission = 25;

Select 1 from AuteurASoumission where idSoumission = 25;
-- DOIT RETOURNER AUCUN ENREGISTREMENT

-- Test de conflit d'interet a partir de l'evaluation
insert into Evaluation (idComiteRelecture, idChercheur, noSoumission) values (13,16,24);
