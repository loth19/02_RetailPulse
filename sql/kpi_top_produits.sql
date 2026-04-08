select produits.produit_id,
       produits.nom,
       produits.categorie,
       round(sum(commandes.montant_total),2) as revenue 
from produits
left join commandes
on produits.produit_id = commandes.produit_id
group by produits.produit_id
ORDER BY revenue DESC
LIMIT 5;