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

INSERT INTO utilisateur(nom, prenom, email, mot_de_passe) 
VALUES ('Nsiala', 'barthe', 'barthensiala@gmail.com', '123rt'),
('Lokwa', 'gedeon', 'gedeonlokwa@gmail.com', '12345'),
('Amanakou', 'josue', 'josueamanakou@gmail.com', '123456'),
('Mindele', 'christ', 'christmindele@gmail.com', '123rum'),
('Luvuezo', 'jason', 'jasonluvuezo@gmail.com', '123hu6');

INSERT INTO conversation(type, nom_groupe) 
VALUES ('privee',NULL),
('privee',NULL),
('groupe','Team FOOT');

INSERT INTO utilisateur_conversation(id_utilisateur, id_conversation, statut_participation, role)
VALUES (1,1,'actif','membre'),
(2,1,'actif','membre'),
(5,2,'actif','membre'),
(3,2,'actif','admin'),
(5,3,'actif','membre'),
(4,3,'actif','membre'),
(3,3,'actif','membre'),
(1,3,'actif','membre');

INSERT INTO message(id_conversation, id_utilisateur, contenu)
VALUES (1,1, 'Salut Gédéon, t''as vu l''exercice de SQL pour demain ?'),
(1,2,'Oui je suis dessus, j''ai un souci avec les jointures'),
(1,1, 'Ok je regarde ça avec toi ce soir');

INSERT INTO message(id_conversation, id_utilisateur, contenu)
VALUES (2,5, 'Josué tu es dispo pour le match samedi ?'),
(2,3,'Oui carrément, à quelle heure ?');

INSERT INTO message(id_conversation, id_utilisateur, contenu)
VALUES (3,5, 'Les gars, entraînement confirmé samedi 15h'),
(3,4,'Reçu, j''y serai'),
(3,3,'Je ramène les maillots'),
(3,1,'Parfait, à samedi !');

INSERT INTO message_statut(id_message, id_utilisateur, statut)
VALUES (1,2,'lu'),
(2,1,'delivre'),
(3,2,'envoye'),
(4,3,'delivre'),
(5,5,'envoye'),
(6,1,'lu'),
(6,3,'lu'),
(6,4,'delivre'),
(7,1,'lu'),
(7,3,'delivre'),
(7,5,'lu'),
(8,1,'delivre'),
(8,4,'envoye'),
(8,5,'lu'),
(9,3,'lu'),
(9,4,'lu'),
(9,5,'lu');

