# 📊 RetailPulse - Projet d'Analyse de Données Retail

Un projet complet d'analyse de données e-commerce avec génération de données synthétiques, nettoyage, analyse SQL et visualisations.

---

## 📋 Table des matières

- [Vue d'ensemble](#vue-densemble)
- [Structure du projet](#structure-du-projet)
- [Architecture de données](#architecture-de-données)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Fichiers importants](#fichiers-importants)
- [KPIs générés](#kpis-générés)
- [Workflow complet](#workflow-complet)

---

## 🎯 Vue d'ensemble

**RetailPulse** est un pipeline d'analyse de données qui :

✅ Génère **1000 commandes synthétiques** pour 200 clients sur 50 produits  
✅ Nettoie les données (doublons, valeurs nulles, aberrantes)  
✅ Persiste les données dans une **base SQLite**  
✅ Calcule **4 KPIs métier** via requêtes SQL  
✅ Crée des **visualisations matplotlib** publication-ready

**Technologies utilisées :**
- Python 3.x
- Pandas (manipulation de données)
- SQLite3 (persistance)
- Faker (données synthétiques)
- Matplotlib (visualisations)
- Jupyter Notebooks

---

## 📁 Structure du projet

```
02_RetailPulse/
├── .git/                           # Versioning Git
├── .gitignore                      # Fichiers à ignorer (*.db-shm, *.db-wal)
├── requirements.txt                # Dépendances Python
├── README.md                       # Ce fichier
│
├── data/                           # 📊 Données brutes et nettoyées
│   └── raw/
│       ├── clients.csv             # 200 clients + métadonnées
│       ├── produits.csv            # 50 produits catégorisés
│       ├── commandes.csv           # 1000 commandes avec montants
│       └── clean/
│           ├── clients_clean.csv
│           ├── produits_clean.csv
│           └── commandes_clean.csv
│
├── src/                            # 💻 Code source
│   ├── generate_data.ipynb         # Notebook : Génération données synthétiques
│   └── data/
│       ├── 02_RetailPulse.db       # 🔐 Base SQLite (3 tables, FK activées)
│       ├── 02_RetailPulse.db-shm   # Cache SQLite (généré, dans .gitignore)
│       ├── 02_RetailPulse.db-wal   # Journal SQLite (généré, dans .gitignore)
│       └── raw/                    # Copies locales des CSVs
│
├── notebooks/                      # 📔 Cahiers d'analyse
│   └── 02_exploration.ipynb        # Notebook : Calcul des KPIs avec SQL
│
├── sql/                            # 🔍 Requêtes KPI réutilisables
│   ├── kpi_CA_mensuel.sql          # Chiffre d'affaires par mois
│   ├── kpi_top_produits.sql        # Top 5 produits par revenu
│   ├── kpi_clients_vip.sql         # Top 10 clients par dépenses
│   └── kpi_periodes_creuses.sql    # 3 mois avec moins de commandes
│
└── outputs/                        # 📈 Résultats & visualisations
    ├── 02_visualisation.ipynb      # Notebook : Génération PNGs
    ├── ca_mensuel.png              # 📊 Graphique : CA mensuel
    ├── top_produits.png            # 📊 Graphique : Top 5 produits
    ├── top_clients.png             # 📊 Graphique : Top 10 clients VIP
    ├── CA_mensuel.csv              # Données intermédiaires (CSV)
    ├── top_produits.csv
    ├── clients_vip.csv
    └── periodes_creuses.csv
```

---

## 🏗️ Architecture de données

### Schema SQLite (3 tables)

#### 1️⃣ **clients** (200 lignes)
```sql
CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY,
    nom TEXT,
    email TEXT,
    ville TEXT,
    date_inscription TEXT
);
```

#### 2️⃣ **produits** (50 lignes)
```sql
CREATE TABLE produits (
    produit_id INTEGER PRIMARY KEY,
    nom TEXT,
    categorie TEXT,
    prix REAL
);
```

#### 3️⃣ **commandes** (1000 lignes)
```sql
CREATE TABLE commandes (
    commande_id INTEGER PRIMARY KEY,
    client_id INTEGER,
    produit_id INTEGER,
    date_commande TEXT,
    quantite INTEGER,
    montant_total REAL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (produit_id) REFERENCES produits(produit_id)
);
```

### Nettoyage appliqué

✅ **Doublons** : 20 doublons volontaires générés → supprimés  
✅ **Valeurs nulles** : 5% emails nulles → remplacées par "inconnue"  
✅ **Aberrantes** : 4% montants aberrants (-2000€ à +999999€) → filtrés  
✅ **Outliers** : Détection IQR (Q1 ± 1.5×IQR) → supprimés  
✅ **Types** : Conversion dates TEXT → DATETIME  

---

## ⚙️ Installation

### Prérequis
- Python 3.8+
- pip

### 1. Cloner le repo
```bash
git clone <url_repo>
cd 02_RetailPulse
```

### 2. Créer l'environnement virtuel
```bash
python -m venv .venv
.venv\Scripts\Activate.ps1  # Windows PowerShell
# ou
source .venv/bin/activate  # Linux/Mac
```

### 3. Installer les dépendances
```bash
pip install -r requirements.txt
```

### 4. Vérifier l'installation
```bash
python -c "import pandas, sqlite3, faker, matplotlib; print('✅ OK')"
```

---

## 🚀 Utilisation

### Étape 1 : Générer les données synthétiques

Ouvrir : `src/generate_data.ipynb`

- 📌 **Cellule 1-5** : Génération des clients/produits/commandes
- 📌 **Cellule 6-7** : Export CSV vers `data/raw/`
- 📌 **Cellule 8-14** : Création base SQLite `src/data/02_RetailPulse.db`

```python
# Exemple de montants au réalisme avec aberrances
montant = prix * quantite  # Attendu ~150€ - 10000€
if random.random() < 0.04:  # 4% aberrances
    montant = random.uniform(-2000.99, 999999)
```

### Étape 2 : Nettoyer les données

Ouvrir : `data/raw/clean/clean_data.ipynb` (à créer si absent)

- Détection et suppression des doublons
- Remplissage des valeurs nulles
- Filtrage des montants négatifs
- Détection outliers via IQR
- Export clean CSVs

### Étape 3 : Calculer les KPIs

Ouvrir : `notebooks/02_exploration.ipynb`

Exécute les 4 requêtes SQL (voir [KPIs générés](#kpis-générés)) et exporte :
- `ca_mensuel.csv`
- `top_produits.csv`
- `clients_vip.csv`
- `periodes_creuses.csv`

**Important** : Les CSVs sont sauvegardés via `df.to_csv("../outputs/nom.csv")` avec le chemin `../` depuis le dossier notebooks/

### Étape 4 : Générer les visualisations

Ouvrir : `outputs/02_visualisation.ipynb`

- Charge les 4 CSVs depuis le répertoire courant
- Crée les graphiques avec matplotlib
- Sauvegarde les PNGs : `ca_mensuel.png`, `top_produits.png`, `top_clients.png`

```python
# Exemple : Chiffre d'affaires mensuel
df = pd.read_csv("ca_mensuel.csv")
ax.plot(df["Mois"], df["Chiffre_affaire"], marker="o", color="#2196F3")
plt.savefig("ca_mensuel.png", dpi=150)
```

---

## 📄 Fichiers importants

| Fichier | Type | Descrition |
|---------|------|-----------|
| `src/generate_data.ipynb` | 📓 Notebook | Génère 1000 commandes + DB |
| `notebooks/02_exploration.ipynb` | 📓 Notebook | Calcule les 4 KPIs |
| `outputs/02_visualisation.ipynb` | 📓 Notebook | Crée les graphiques PNG |
| `sql/kpi_*.sql` | 📝 SQL | Requêtes réutilisables |
| `src/data/02_RetailPulse.db` | 🔐 DB | SQLite persistant |
| `requirements.txt` | ⚙️ Config | Dépendances (`pandas`, `faker`, etc) |

---

## 📊 KPIs générés

### 1. **CA Mensuel** (`kpi_CA_mensuel.sql`)
```sql
SELECT round(sum(montant_total),2) as Chiffre_affaire,
       strftime('%Y-%m', date_commande) as Mois
FROM commandes
GROUP BY strftime('%Y-%m', date_commande)
ORDER BY Mois ASC;
```
**Visualisation** : Graphique linéaire avec marqueurs  
**Fichier PNG** : `outputs/ca_mensuel.png`

### 2. **Top 5 Produits** (`kpi_top_produits.sql`)
```sql
SELECT p.nom, 
       round(sum(c.montant_total),2) as revenue
FROM commandes c
LEFT JOIN produits p ON c.produit_id = p.produit_id
GROUP BY p.produit_id
ORDER BY revenue DESC
LIMIT 5;
```
**Visualisation** : Diagramme en barres horizontales (5 couleurs)  
**Fichier PNG** : `outputs/top_produits.png`

### 3. **Top 10 Clients VIP** (`kpi_clients_vip.sql`)
```sql
SELECT clients.client_id,
       clients.nom,
       clients.ville,
       round(COALESCE(sum(commandes.montant_total),0),2) as depenses
FROM clients
LEFT JOIN commandes ON clients.client_id = commandes.client_id
GROUP BY clients.client_id
ORDER BY depenses DESC
LIMIT 10;
```
**Visualisation** : Histogramme vertical avec valeurs (bleu)  
**Fichier PNG** : `outputs/top_clients.png`

### 4. **Périodes Creuses** (`kpi_periodes_creuses.sql`)
```sql
SELECT COUNT(*) as nbre_commandes,
       strftime('%Y-%m', date_commande) as mois
FROM commandes
GROUP BY mois
ORDER BY nbre_commandes ASC
LIMIT 3;
```
**Insight** : Identifie les 3 mois avec le moins de commandes

---

## 🔄 Workflow complet

```
┌─────────────────────────────────────────────────────────┐
│ 1. GÉNÉRATION (src/generate_data.ipynb)                │
│    ├─ Faker: 200 clients + 50 produits + 1000 orders   │
│    └─ Export: data/raw/*.csv + SQLite DB               │
└──────────────────┬──────────────────────────────────────┘
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
