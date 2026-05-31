# 🚀 APEX TRADE — Guide de déploiement complet

## Ce que vous avez dans ce dossier
- `src/` → Le code de la plateforme
- `schema.sql` → La base de données à créer
- `.env` → Vos clés de connexion
- `package.json` → Les dépendances

---

## ÉTAPE 1 — Créer la base de données Supabase

1. Allez sur **supabase.com** → connectez-vous → ouvrez votre projet **apextrade**
2. Dans le menu gauche, cliquez sur **SQL Editor**
3. Cliquez **New Query**
4. Ouvrez le fichier `schema.sql` de ce dossier
5. Copiez **tout** le contenu et collez-le dans l'éditeur
6. Cliquez le bouton **RUN** (triangle vert)
7. Vous devriez voir "Success" → votre base de données est prête !

---

## ÉTAPE 2 — Créer votre compte Chef

1. Dans Supabase, allez dans **Authentication** → **Users**
2. Cliquez **Invite user** (ou **Add user**)
3. Entrez votre email et un mot de passe
4. Confirmez → votre compte Chef est créé

---

## ÉTAPE 3 — Installer Node.js sur votre ordinateur

1. Allez sur **nodejs.org**
2. Téléchargez la version **LTS** (bouton vert)
3. Installez-le (cliquez Suivant partout)
4. Redémarrez votre ordinateur

---

## ÉTAPE 4 — Lancer la plateforme sur votre ordinateur

1. Ouvrez **Terminal** (Mac) ou **Invite de commandes** (Windows)
2. Naviguez vers ce dossier :
   ```
   cd chemin/vers/apextrade
   ```
3. Installez les dépendances :
   ```
   npm install
   ```
4. Lancez la plateforme :
   ```
   npm start
   ```
5. Votre navigateur s'ouvre sur **http://localhost:3000**
6. Connectez-vous avec l'email et mot de passe créés à l'étape 2

---

## ÉTAPE 5 — Mettre en ligne sur Vercel

1. Allez sur **github.com** → créez un compte si pas déjà fait
2. Cliquez **+** → **New repository** → appelez-le `apextrade`
3. Uploadez tous les fichiers de ce dossier
4. Allez sur **vercel.com** → connectez-vous avec GitHub
5. Cliquez **Add New Project** → choisissez `apextrade`
6. Dans **Environment Variables**, ajoutez :
   - `REACT_APP_SUPABASE_URL` = `https://htxpugitawqrzgwqitim.supabase.co`
   - `REACT_APP_SUPABASE_ANON_KEY` = votre clé anon
7. Cliquez **Deploy** → en 2 minutes votre plateforme est en ligne !

---

## ÉTAPE 6 — Faire des mises à jour

Quand vous voulez modifier quelque chose :
1. Demandez à Claude le fichier modifié
2. Remplacez le fichier dans votre dossier
3. Sur votre ordinateur : `npm start` pour tester
4. Sur GitHub : uploadez le fichier modifié → Vercel redéploie automatiquement

---

## Fichiers importants à connaître

| Fichier | À quoi ça sert |
|---------|---------------|
| `src/pages/Dashboard.js` | Tout l'interface principale |
| `src/pages/Login.js` | Page de connexion |
| `src/lib/supabase.js` | Connexion base de données |
| `.env` | Vos clés secrètes |
| `schema.sql` | Structure de la base de données |

---

## En cas de problème

Envoyez à Claude le message d'erreur exact et il corrigera le fichier concerné.
