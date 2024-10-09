-- Vérifier si la base de données existe et la supprimer si nécessaire
IF DB_ID('annuaire_entreprise') IS NOT NULL
BEGIN
    DROP DATABASE annuaire_entreprise;
END
GO

-- Créer la base de données annuaire_entreprise
CREATE DATABASE annuaire_entreprise;
GO

-- Utiliser la base de données
USE annuaire_entreprise;
GO

-- Vérifier si l'utilisateur agb existe et le supprimer si nécessaire
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'agb')
BEGIN
    DROP LOGIN agb;
END
GO

-- Créer un utilisateur SQL appelé agb avec le mot de passe @Pa$$w0rd
CREATE LOGIN agb WITH PASSWORD = '@Pa$$w0rd';
GO

-- Vérifier si l'utilisateur agb existe déjà dans la base de données et le supprimer si nécessaire
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'agb')
BEGIN
    DROP USER agb;
END
GO

-- Créer un utilisateur dans la base de données annuaire_entreprise
CREATE USER agb FOR LOGIN agb;
GO

-- Donner des privilèges db_owner à l'utilisateur agb
ALTER ROLE db_owner ADD MEMBER agb;
GO

-- Vérifier si la table Entreprises existe et la supprimer si nécessaire
IF OBJECT_ID('Entreprises', 'U') IS NOT NULL
BEGIN
    DROP TABLE Entreprises;
END
GO

-- Créer la table Entreprises
CREATE TABLE Entreprises (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nom NVARCHAR(100) NOT NULL,
    Adresse NVARCHAR(255),
    Ville NVARCHAR(100),
    CodePostal NVARCHAR(10),
    Telephone NVARCHAR(15),
    Email NVARCHAR(100)
);
GO

-- Insérer des données dans la table Entreprises
INSERT INTO Entreprises (Nom, Adresse, Ville, CodePostal, Telephone, Email) VALUES
('Airbus', '1 Rond-Point Maurice Bellonte', 'Blagnac', '31707', '0562121212', 'contact@airbus.com'),
('Renault', '13-15 Quai Le Gallo', 'Boulogne-Billancourt', '92100', '0176945678', 'contact@renault.com'),
('Oréal', '14 Rue Royale', 'Paris', '75008', '0143735000', 'contact@loreal.com'),
('TotalEnergies', '2 Place Jean Millier', 'La Défense', '92078', '0147412000', 'contact@totalenergies.com'),
('Orange', '78 Rue Olivier de Serres', 'Paris', '75015', '0144390000', 'contact@orange.com');
GO
