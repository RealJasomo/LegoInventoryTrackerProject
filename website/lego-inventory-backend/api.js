var express = require('express');
var router = express.Router();
var bodyParser = require('body-parser');
router.use(bodyParser.json());
//Controllers
var userController = require('./controllers/UserController');
var legoSetController = require('./controllers/LegoSetController');
var legoBrickController = require('./controllers/LegoBrickController');

//Middleware
var loginAttemptLimiter = require('./middleware/loginAttempt');
var authorization = require('./middleware/Authorization');


// Lego Brick Routes //

// GET all bricks
router.get('/bricks', legoBrickController.legoBricksList); 

//GET the nth page of n lego bricks
router.get('/bricks/:page/:count', legoBrickController.legoBricksListByPageCount);

//GET brick information with id
router.get('/brick', legoBrickController.legoBrickInformation);

//POST wants brick with id
router.post('/brick/wants', authorization.authorize, legoBrickController.wantsLegoBrick);

//POST owns brick with id
router.post('/brick/owns', authorization.authorize, legoBrickController.ownsLegoBrick);

//POST update wanted brick
router.post('/brick/wants/update', authorization.authorize, legoBrickController.updateFavoriteBrick);

//POST update ownded brick
router.post('/brick/owns/update', authorization.authorize, legoBrickController.updateOwnedBrick);

//DELETE delete wanted brick
router.delete('/brick/wants/delete', authorization.authorize, legoBrickController.deleteFavoriteBrick);

//DELETE delete wanted brick
router.delete('/brick/owns/delete', authorization.authorize, legoBrickController.deleteOwnedBrick);

//GET owned bricks 
router.get('/brick/owns', authorization.authorize, legoBrickController.getOwnedBricks);

//GET wanted bricks 
router.get('/brick/wants', authorization.authorize, legoBrickController.getWantedBricks);

//POST search for brick
router.post('/brick/search', authorization.authorize, legoBrickController.brickSearch);

//GET get onl availabl bricks 
router.get('/brick/available', authorization.authorize, legoBrickController.getAvailableBricks);


// Lego Set Routes //

// GET all sets
router.get('/sets', legoSetController.legoSetsList); 

//GET the nth page of n lego sets
router.get('/sets/:page/:count', legoSetController.legoSetsListByPageCount);

//GET set information with id
router.get('/set', legoSetController.legoSetInformation);

//GET included bricks from set with id
router.get('/set/:setid/includes', legoSetController.legoSetIncludes);

//POST wants set with id
router.post('/set/wants', authorization.authorize, legoSetController.wantsLegoSet);

//POST owns set with id
router.post('/set/owns', authorization.authorize, legoSetController.ownsLegoSet);

//GET owned sets 
router.get('/set/owns', authorization.authorize, legoSetController.getOwnedSets);

//GET wanted sets 
router.get('/set/wants', authorization.authorize, legoSetController.getWantedSets);

//POST search for set
router.post('/set/search', authorization.authorize, legoSetController.setSearch);

//POST update owned set
router.post('/set/owns/update', authorization.authorize, legoSetController.updateOwnedSet);

//DELETE owned set
router.delete('/set/owns/delete', authorization.authorize, legoSetController.deleteOwnedSet);

//POST update wants set
router.post('/set/wants/update', authorization.authorize, legoSetController.updateFavoriteSet);

//DELETE wanted set
router.delete('/set/wants/delete',authorization.authorize, legoSetController.deleteFavoriteSet);

//GET Buildable sets
router.get('/set/buildable', authorization.authorize, legoSetController.getBuildableSets);

// User Routes //

//POST login user
router.post('/users/login',loginAttemptLimiter.loginAttempt,userController.loginUser);

//POST create new user
router.post('/users/create', userController.createUser);

//PUT update password
router.put('/users/updatePassword', authorization.authorize, userController.updateUserPassword);

//DELETE delete user
router.delete('/users/delete', authorization.authorize, userController.deleteUser);

module.exports = router;