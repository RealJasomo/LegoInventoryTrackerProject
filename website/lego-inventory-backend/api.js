var express = require('express');
var router = express.Router();

//Controllers
var userController = require('./controllers/UserController');
var legoSeController = require('./controllers/LegoSetController');
var legoModelController = require('./controllers/LegoModelController');
var legoBrickController = require('./controllers/LegoBrickController');

// Lego Brick Routes //

// GET all bricks
router.get('/bricks', legoBrickController.legoBricksList); 

//GET the nth page of n lego bricks
router.get('/bricks/:page/:count', legoBrickController.legoBricksListByPageCount);

//GET brick information with id
router.get('/brick/:id', legoBrickController.legoBrickInformation);

//POST wants brick with id
router.post('/brick/wants/:brickid', legoBrickController.wantsLegoBrick);

//POST owns brick with id
router.post('/brick/owns/:brickid', legoBrickController.ownsLegoBrick);


module.exports = router;