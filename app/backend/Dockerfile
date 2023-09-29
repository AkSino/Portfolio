# Utilisez une image de base appropriée (par exemple, python:3.9)
FROM python:3.9

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les dépendances et le code du serveur
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY main.py .

# Exposez le port sur lequel le serveur FastAPI s'exécute (par exemple, 8000)
EXPOSE 8000

# Commande pour exécuter le serveur FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
