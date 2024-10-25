const express = require('express');
const cors = require('cors'); 
const app = express();
const port = 3030;


const AppRoutes = require('./routes/routes.js');

app.use(cors());
app.use('/', AppRoutes);

app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
