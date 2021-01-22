var express = require('express');
var router = express.Router();

//Controllers
var userController = require('./controllers/UserController');
var legoSetController = require('./controllers/LegoSetController');
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

// Lego Model Routes //

// GET all models
router.get('/models', legoModelController.legoModelsList); 

//GET the nth page of n lego models
router.get('/models/:page/:count', legoModelController.legoModelsListByPageCount);

//GET model information with id
router.get('/model/:modelid', legoModelController.legoModelInformation);

//GET included bricks from model with id
router.get('/model/:modelid/includes', legoModelController.legoModelIncludes);

//POST builds model with id
router.post('/model/build/:modelid', legoModelController.buildsLegoModel);

// Lego Set Routes //

// GET all sets
router.get('/sets', legoSetController.legoSetsList); 

//GET the nth page of n lego sets
router.get('/sets/:page/:count', legoSetController.legoSetsListByPageCount);

//GET set information with id
router.get('/set/:setid', legoSetController.legoSetInformation);

//GET included bricks from set with id
router.get('/set/:setid/includes', legoSetController.legoSetIncludes);

//POST wants set with id
router.post('/set/wants/:setid', legoSetController.wantsLegoSet);

//POST owns set with id
router.post('/set/owns/:setid', legoSetController.ownsLegoSet);

// User Routes //

//GET login user
router.get('/users/login', userController.loginUser);

//POST create new user
router.post('/users/create', userController.createUser);

//PUT update password
router.put('/users/updatePassword', userController.updateUserPassword);

//DELETE delete user
router.delete('/users/delete', userController.deleteUser);

module.exports = router;