const express = require('express');
const router = express.Router();
const entrepriseController = require('../controllers/entrepriseController');

// Route pour récupérer les entreprises
router.get('/entreprises', entrepriseController.getEntreprises);
router.get('/', entrepriseController.getAppInfos);

module.exports = router;
