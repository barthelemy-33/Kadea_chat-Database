CREATE DATABASE kadea_chat;

CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    telephone VARCHAR(100),
    langue VARCHAR(100),
    avatar VARCHAR(255),
    bio VARCHAR(255),
    date_creation TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP
);

CREATE TABLE conversation (
    id_conversation SERIAL PRIMARY KEY,
    type VARCHAR(20) NOT NULL CHECK(type IN('privee','groupe')),
    nom_groupe VARCHAR(150),
    date_creation TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE message (
    id_message SERIAL PRIMARY KEY,
    id_conversation INTEGER REFERENCES conversation(id_conversation) NOT NULL,
    id_utilisateur INTEGER REFERENCES utilisateur(id_utilisateur) NOT NULL,
    contenu TEXT NOT NULL,
    date_envoi TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP
);

CREATE TABLE utilisateur_conversation (
    id_utilisateur INTEGER REFERENCES utilisateur(id_utilisateur),
    id_conversation INTEGER REFERENCES conversation(id_conversation),
    statut_participation VARCHAR(20) NOT NULL DEFAULT 'actif' 
    CHECK(statut_participation IN('actif','quitte')),
    role VARCHAR(20) NOT NULL DEFAULT 'membre' CHECK(role IN ('membre','admin')),
    date_ajout TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_utilisateur,id_conversation)
);

CREATE TABLE message_statut (
    id_message INTEGER REFERENCES message(id_message),
    id_utilisateur INTEGER REFERENCES utilisateur(id_utilisateur),
    statut VARCHAR(20) NOT NULL CHECK(statut IN('envoye','delivre','lu')),
    date_statut TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_message,id_utilisateur)
);
