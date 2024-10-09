const express = require('express');
const app = express();
const port = 3000;


const AppRoutes = require('./routes/routes.js');


app.use('/', AppRoutes);

app.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
