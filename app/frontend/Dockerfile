# Utilisez une image de base appropriée (par exemple, node:14)
FROM node:14

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers statiques (index.html, js, etc.) dans le conteneur
COPY . .

# Installez http-server (ou tout autre serveur HTTP de votre choix)
RUN npm install -g http-server

# Exposez le port sur lequel le serveur HTTP local s'exécute (par exemple, 8080)
EXPOSE 8080

# Commande pour exécuter le serveur HTTP local
CMD ["http-server"]
