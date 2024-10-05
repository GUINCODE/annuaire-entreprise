const sql = require('mssql');
require('dotenv').config();

const dbConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_DATABASE,
    options: {
      encrypt: true, 
      trustServerCertificate: true
    }
  };


const getEntreprises = async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const result = await sql.query`SELECT * FROM Entreprises`;
    res.json(result.recordset);
  } catch (err) {
    console.error('Erreur lors de la récupération des données:', err);
    res.status(500).send('Erreur lors de la récupération des données');
  } finally {
    sql.close();
  }
};


const getAppInfos = (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html lang="fr">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Annuaire Entreprise - API</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                    background-color: #f4f4f4;
                }
                .container {
                    text-align: center;
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
                h1 {
                    color: #333;
                }
                p {
                    color: #666;
                }
                a {
                    text-decoration: none;
                    color: #007BFF;
                    font-weight: bold;
                }
                a:hover {
                    text-decoration: underline;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Bienvenue sur l'API Annuaire Entreprise</h1>
                <p>Utilisez les endpoints pour accéder aux données des entreprises.</p>
                <p><a href="/entreprises">Voir les entreprises</a></p>
            </div>
        </body>
        </html>
    `);
};

module.exports = {
  getEntreprises,
    getAppInfos
};
