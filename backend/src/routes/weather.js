var express = require('express');
var router = express.Router();

const weatherController = require("../controllers/weather");

router.get('/weather', weatherController.getWeather);

module.exports = router;