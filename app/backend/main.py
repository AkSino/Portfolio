from __future__ import annotations

import os  # Importez le module 'os' pour accéder aux variables d'environnement

import psycopg2
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from psycopg2 import sql
from pydantic import BaseModel


app = FastAPI()

# Créez une instance de CORSMiddleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    # Vous pouvez spécifier les méthodes autorisées (ex. ["GET", "POST"])
    allow_methods=['GET', 'POST', 'PUT', 'DELETE'],
    # Vous pouvez spécifier les en-têtes autorisés (ex. ["Content-Type"])
    allow_headers=['*'],
)

# Utilisez DATABASE_URL à partir des variables d'environnement
DATABASE_URL = os.environ.get('DATABASE_URL')

# Vérifiez si DATABASE_URL est défini, sinon utilisez une valeur par défaut
if not DATABASE_URL:
    raise ValueError('DATABASE_URL environment variable is not set.')

# Create a connection to the database
conn = psycopg2.connect(DATABASE_URL)

# Fonction pour créer la table


def create_visitor_data_table() -> None:
    cursor = conn.cursor()

    create_table_query = sql.SQL("""
        CREATE TABLE IF NOT EXISTS visitor_data (
            id SERIAL PRIMARY KEY,
            page VARCHAR(255) NOT NULL,
            timestamp VARCHAR(255) NOT NULL
        )
    """)

    cursor.execute(create_table_query)
    conn.commit()

    cursor.close()


@app.on_event('startup')
def create_table() -> None:
    create_visitor_data_table()

# API Route to receive visitor data


class VisitorData(BaseModel):
    page: str
    timestamp: str


@app.post('/api/track')
async def track_visitor(visitor_data: VisitorData):
    try:
        # Insert visitor data into the database
        cursor = conn.cursor()
        cursor.execute(
            'INSERT INTO visitor_data (page, timestamp) VALUES (%s, %s);',
            (visitor_data.page, visitor_data.timestamp),
        )
        conn.commit()
        cursor.close()
        return {'message': 'Visitor data saved successfully'}
    except Exception as e:
        return {'error': str(e)}

if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host='0.0.0.0', port=8000)
