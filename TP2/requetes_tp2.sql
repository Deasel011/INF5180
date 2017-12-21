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
where t.idEdition = searchValue
group by idTrack

/*Affichage du nombre moyen d'article affecte a un membre pour un comite donne*/
select idChercheur, count(noSoumission) / count(idChercheur)
from Evaluation
where idComiteRelecture = searchValue
group by idChercheur