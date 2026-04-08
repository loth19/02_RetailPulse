select COUNT(*) as nbre_commandes,strftime('%Y-%m', date_commande) as mois 
from commandes
GROUP BY mois 
ORDER BY nbre_commandes ASC
LIMIT 3;
