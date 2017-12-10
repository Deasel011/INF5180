
-- Exercices Demo

create procedure AuteurActif (titreConference as varchar(50)
as
avgEditions int;
begin
select count(*)/2 into avgEditions from Edition e
where e.titre = titreConference

select idChercheur from Conference c
join Edition e on c.titre = e.titre
join Track t on t.idEdition = e.idEdition
join Soumission s on s.idTrack = t.idTrack
join AuteurASoumission a.idSoumission = s.noSoumission
group by idChercheur, e.idEdition
where count(insoumission) > avgEditions
end;
