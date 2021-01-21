/***
 * Lego Brick API Controller
 * 
 */

 //tedious will be used for database connection
var Connection = require('tedious').Connection;


//return all lego bricks ROUTE:: /api/bricks/
exports.legoBricksList = (req, res) => {
    res.send('NOT IMPLEMENTED YET all brick informations');
};

//return count :count lego bricks of page :page   ROUTE:: /api/bricks/:page/:count
exports.legoBricksListByPageCount = (req, res) => {
    var page = req.params.page;
    var count = req.params.count;
    res.send(`NOT IMPLEMENTED YET bricks page ${page} of ${count} bricks per page`);
};

//return brick information with id :brickID ROUTE:: /api/brick/:id
exports.legoBrickInformation = (req, res) =>{
    var brickID = req.params.id;
    res.send(`NOT IMPLEMENTED YET brick information ${brickID}`)
};

//Post user wants lego brick with id :brickid ROUTE:: /api/brick/wants/:brickid
exports.wantsLegoBrick = (req, res) => {
    var brickID = req.params.brickid;
    res.send(`NOT IMPLEMENTED YET wants brick ${brickID}`);
};

//Post user owns lego brick with id :brickid   ROUTE:: /api/brick/owns/:brickid
exports.ownsLegoBrick = (req, res) => {
    var brickID = req.params.brickid;
    res.send(`NOT IMPLEMENTED YET owns brick ${brickID}`);
};
