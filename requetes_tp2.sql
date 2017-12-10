/*Affichage des tracks d'un conference*/
select *
from Track
where idEdition = searchValue

/*Affichage des noms des membre de comite de relecture d'un track*/
select nom
from Chercheur c
	inner join Evaluation e on e.idChercheur = c.idChercheur
	inner join Membre m on m.idChercheur = c.idChercheur
	inner join ComiteRelecture cr on cr.idComiteRelecture = m.idComiteRelecture
where cr.idTrack = searchValue


/*Affichage du nombre d'article soumis par track pour un conference*/
select idTrack, count(noSoumission)
from Track t
	inner join Soumission s on t.idTrack = s.idTrack
where t.idEdition = serachValue

/*Affichage nombre moyen d'article par membre d'un comite*/
create view nbSoumisisonView
	select count(noSoumission) as nbSoumisisons
	from Evalutation
	where idChercheur = searchValue;

select avg(nbSoumisisons) from nbSoumisisonView