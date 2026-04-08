select clients.client_id,
       clients.nom,
       clients.ville,
       round(COALESCE(sum(commandes.montant_total),0),2) as depenses 
from clients
left join commandes
on clients.client_id = commandes.client_id
group by clients.client_id
ORDER BY depenses DESC
LIMIT 10;