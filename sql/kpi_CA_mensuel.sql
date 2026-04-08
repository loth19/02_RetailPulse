select round(sum(montant_total),2) as Chiffre_affaire , strftime('%Y-%m', date_commande) as Mois
from commandes
GROUP BY strftime('%Y-%m', date_commande)
ORDER BY strftime('%Y-%m', date_commande) ASC;