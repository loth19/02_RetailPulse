# RetailPulse

Pipeline Data Analytics de bout en bout sur un cas retail: generation de donnees, nettoyage, calcul de KPI SQL et visualisations prêtes a presenter.

## Pitch recrutement

Ce projet montre ma capacite a livrer une chaine data complete:

- conception d'un jeu de donnees retail realiste,
- nettoyage et fiabilisation des donnees,
- modelisation et interrogation SQL,
- production de livrables business (CSV + graphiques).

## Resultats obtenus

### KPI business (sorties pipeline)

- CA cumule observe: 498578206.98
- CA mensuel moyen: 38352169.77
- Mois le plus performant: 2026-03 (48149756.56)
- Mois le plus creux: 2026-04 (5248217.31)

### Top 5 produits (par revenue)

| Rang | Produit | Categorie | Revenue |
|---|---|---|---:|
| 1 | réveiller6 | Photo | 15728466.14 |
| 2 | paupière16 | Audio | 15147544.97 |
| 3 | phrase15 | Telephonie | 14492147.68 |
| 4 | auteur7 | Photo | 14294467.13 |
| 5 | prochain9 | Informatique | 13691166.70 |

### Top clients VIP (aperçu)

| Rang | Client | Ville | Depenses |
|---|---|---|---:|
| 1 | Grégoire noël | Henry | 6062321.03 |
| 2 | Lucie delmas | Pierre | 6024135.06 |
| 3 | Sabine le olivier | Turpin | 5822438.95 |

### Periodes creuses

| Mois | Nombre de commandes |
|---|---:|
| 2026-04 | 8 |
| 2025-04 | 72 |
| 2025-12 | 74 |

## Visuels du projet

Les graphiques sont disponibles dans le depot:

- outputs/ca_mensuel.png
- outputs/top_produits.png
- outputs/top_clients.png

## Architecture de la pipeline

1. Generation de donnees synthetiques dans src/generate_data.ipynb.
2. Nettoyage dans data/raw/clean/clean_data.ipynb.
3. Calcul des KPI dans notebooks/02_exploration.ipynb via sql/kpi_*.sql.
4. Visualisation et export dans outputs/02_visualisation.ipynb.

## Structure du projet

```text
02_RetailPulse/
|-- data/
|   |-- raw/
|   |   |-- clients.csv
|   |   |-- commandes.csv
|   |   |-- produits.csv
|   |   `-- clean/
|   |       |-- clean_data.ipynb
|   |       `-- data/clean/
|   |           |-- clients.csv
|   |           |-- commandes.csv
|   |           `-- produits.csv
|-- notebooks/
|   `-- 02_exploration.ipynb
|-- outputs/
|   |-- 02_visualisation.ipynb
|   |-- CA_mensuel.csv
|   |-- clients_vip.csv
|   |-- periodes_creuses.csv
|   |-- top_produits.csv
|   |-- ca_mensuel.png
|   |-- top_produits.png
|   `-- top_clients.png
|-- sql/
|   |-- kpi_CA_mensuel.sql
|   |-- kpi_clients_vip.sql
|   |-- kpi_periodes_creuses.sql
|   `-- kpi_top_produits.sql
|-- src/
|   |-- generate_data.ipynb
|   `-- data/
|       `-- 02_RetailPulse
|-- requirements.txt
`-- readme.md
```

## Stack technique

- Python (Pandas, Faker, Matplotlib)
- SQLite
- SQL
- Jupyter Notebook

## Lancer le projet

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Ordre d'execution recommande:

1. src/generate_data.ipynb
2. data/raw/clean/clean_data.ipynb
3. notebooks/02_exploration.ipynb
4. outputs/02_visualisation.ipynb

## Points forts du projet

- Livrables orientés metier (KPI actionnables).
- SQL propre et reutilisable (fichiers dedies dans sql/).
- Pipeline reproductible de la data brute au reporting.

## Auteur

Projet realise par loth19.
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 2. NETTOYAGE (data/raw/clean/clean_data.ipynb)         │
│    ├─ Suppression doublons                             │
│    ├─ Remplissage nulls (emails)                       │
│    ├─ Filtre aberrances (montants négatifs)            │
│    ├─ Détection outliers (IQR)                         │
│    └─ Export: data/raw/clean/*.csv                     │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 3. ANALYSE SQL (notebooks/02_exploration.ipynb)        │
│    ├─ Lecture: src/data/02_RetailPulse.db              │
│    ├─ Exécution: sql/kpi_*.sql                         │
│    └─ Export: outputs/*.csv                            │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 4. VISUALISATION (outputs/02_visualisation.ipynb)      │
│    ├─ Charge: outputs/*.csv                            │
│    ├─ Matplotlib: 4 graphiques professionnels          │
│    └─ Sauvegarde: outputs/*.png (150 dpi)             │
└─────────────────────────────────────────────────────────┘
```

---

## 🔧 Configuration Git

Le projet utilise Git pour versioning avec `.gitignore` :

```
*.db-shm          # Caches SQLite (ignorés)
*.db-wal          # Journaux SQLite (ignorés)
.venv/            # Environnement virtuel (ignoré)
__pycache__/      # Cache Python (ignoré)
```

### Commits disponibles
```bash
git log --oneline
# feat: add data generation pipeline
# feat: add SQL KPI queries
# chore: update gitignore for SQLite temp files
```

---

## 📈 Résultats attendus

Après exécution complète :

✅ **3 tables SQLite** avec intégrité référentielle  
✅ **1000 commandes nettoyées** (doublons supprimés)  
✅ **4 requêtes SQL** testées et optimisées  
✅ **4 visualisations PNG** publication-ready  
✅ **6 fichiers CSV intermédiaires** pour traceabilité  

---

## 🐛 Dépannage

### ❌ Erreur : `FileNotFoundError: CA_mensuel.csv`
**Solution** : Assurez-vous d'exécuter d'abord `notebooks/02_exploration.ipynb`

### ❌ Erreur : `sqlite3.OperationalError: no such table`
**Solution** : Vérifiez que `src/generate_data.ipynb` a createé les tables (run cells 8-14)

### ❌ Graphiques matplotlib vides
**Solution** : Vérifiez les noms de colonnes dans les CSVs vs le code matplotlib

### ❌ Chemin d'accès introuvable
**Solution** : Rappelez-vous : depuis `notebooks/` → utiliser `../outputs/`  
depuis `outputs/` → utiliser juste le nom du fichier

---

## 📝 Licence

Projet personnel - Utilisation libre

---

## 👤 Auteur

Créé avec ❤️ par **Codo** - 8 avril 2026

---

## 🎓 Points d'apprentissage clés

1. **Pipeline de données** : Gen → Clean → Analyze → Visualize
2. **Relatif vs Absolu** : Gérer les chemins d'accès entre notebooks
3. **Qualité des données** : Nettoyage/validation avant analyse
4. **SQL en production** : Requêtes réutilisables vs scripts inline
5. **Visualisation** : Matplotlib pour publication-ready charts

---

**À jour au 8 avril 2026** ✨
