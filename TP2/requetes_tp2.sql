/*Affichage des tracks d'un conference*/
select Track.titre, Track.description
from Conference
join Edition on Edition.titre = Conference.titre
join Track on Track.idEdition = Edition.idEdition
where Conference.acronyme = unAcronyme ;

/*Affichage des noms des membre de comite de relecture d'un track*/
select c.nom
from ComiteRelecture cr
 join Membre m on cr.idComiteRelecture = m.idComiteRelecture
 join Chercheur c on m.idChercheur = c.idChercheur
where cr.idTrack = unIdTrack ;

/*Affichage du nombre d'article soumis par track pour un conference*/
select Track.description, count(noSoumission)
from Conference
join Edition on Conference.Titre = Edition.Titre
join Track on Track.idEdition = Edition.idEdition
join Soumission on Soumission.idTrack = Track.idTrack
where Conference.acronyme = unAcronyme
group by Track.description;


/*Affichage du nombre moyen d'article affecte a un membre pour un comite donne*/
select avg(count(noSoumission))
from Evaluation
where idComiteRelecture = unIdComiteRelecture
group by idChercheur;
