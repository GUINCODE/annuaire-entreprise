# Utiliser une image de base Node.js
FROM node:18

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier package.json et package-lock.json dans le répertoire de travail
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le code source de l'application dans le conteneur
COPY . .



# Exposer le port sur lequel l'application va s'exécuter
EXPOSE 3000

# Spécifier la commande pour lancer l'application
CMD ["node", "src/server.js"]