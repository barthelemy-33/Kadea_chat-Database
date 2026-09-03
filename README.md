# Kadea Chat — Base de données

## Présentation

Kadea Chat est une plateforme de messagerie destinée aux apprenants de Kadea, permettant de créer un compte, se connecter, consulter ses conversations et ses messages, envoyer des messages et consulter son profil.

Ce dépôt contient la conception et la mise en place de la couche données de l'application : modélisation relationnelle (MCD/MLD), script SQL de création de la base PostgreSQL, données d'exemple et requêtes de test. Il fait suite au développement du frontend de Kadea Chat et prépare le terrain pour le futur développement backend (API REST connectée à cette base).

## Technologies

- PostgreSQL
- pgAdmin
- Draw.io
- SQL

## Modélisation

La base repose sur 3 entités principales et 2 relations many-to-many portant des attributs, transformées en tables d'association :

- **utilisateur** — les comptes de l'application (identifiant, nom, prénom, email, mot de passe, etc.)
- **conversation** — les fils de discussion, privés (1-à-1) ou de groupe (`type` + `nom_groupe`)
- **message** — les messages envoyés, rattachés à une conversation et à un auteur (utilisateur)
- **utilisateur_conversation** — table d'association qui gère la participation d'un utilisateur à une conversation (statut de participation, rôle membre/admin)
- **message_statut** — table d'association qui gère le statut d'un message (envoyé / délivré / lu) **par destinataire**, puisque ce statut diffère d'un utilisateur à l'autre dans une même conversation de groupe

Les relations clés :
- un utilisateur peut participer à plusieurs conversations, et une conversation peut avoir plusieurs participants (N:N via `utilisateur_conversation`)
- un utilisateur peut envoyer plusieurs messages, mais un message n'a qu'un seul auteur (1:N)
- une conversation peut contenir plusieurs messages, mais un message appartient à une seule conversation (1:N)
- un message peut avoir un statut différent pour chacun de ses destinataires (N:N via `message_statut`)

Le détail complet des champs, types PostgreSQL, contraintes et descriptions est disponible dans le fichier Draw.io (onglet "Dictionnaire de données").

## Installation

1. Avoir PostgreSQL installé et un serveur accessible (via pgAdmin ou `psql`).
2. Exécuter la ligne `CREATE DATABASE kadea_chat;` en étant connecté à une base existante (ex: `postgres`).
3. Se connecter ensuite à la base `kadea_chat` nouvellement créée.
4. Exécuter le reste du script `database.sql` (création des tables, contraintes, données d'exemple, requêtes de test) sur cette base.

```bash
psql -U <barthelemy > -d postgres -c "CREATE DATABASE kadea_chat;"
psql -U <barthelemy > -d kadea_chat -f database.sql
```

Ou directement depuis pgAdmin, via le Query Tool, en suivant le même ordre.

## Draw.io

Lien vers le fichier Draw.io (lecture seule) contenant le dictionnaire de données, le MCD et le MLD :
https://app.diagrams.net/#G1ebweERGIUN8voqfc8gsq9aoqg4a0mufb#%7B%22pageId%22%3A%22s-sP-pBZMLddxoD3_K1O%22%7D

## Structure du projet

```
Kadea_chat_Database/
├── database.sql        # Script complet : création de la base, tables, contraintes, données d'exemple, requêtes de test
├── README.md            # Ce fichier
└── screenshots/          # Captures pgAdmin (structure de la base, exécution des requêtes, résultats)
```