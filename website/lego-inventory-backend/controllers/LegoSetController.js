/***
 * Lego Set API Controller
 * 
 */

 //tedious will be used for database connection
 var sql = require("mssql");
 var config = require('./DbConfig').config;

  //return all lego Sets ROUTE:: /api/sets/
exports.legoSetsList = (req, res) => {
    res.send('NOT IMPLEMENTED YET all Set informations');
};

//return count :count lego Sets of page :page   ROUTE:: /api/sets/:page/:count
exports.legoSetsListByPageCount = (req, res) => {
    var page = req.params.page;
    var count = req.params.count;
    res.send(`NOT IMPLEMENTED YET Sets page ${page} of ${count} Sets per page`);
};

//return included lego brick ids and quantities  for set with id :setid ROUTE:: /api/set/:setid/includes
exports.legoSetIncludes = (req, res) => {
    var setID = req.params.setid;
    res.send(`NOT IMPLEMENTED YET set ${setID} includes ....`);
};

//Post user own set with id :setid ROUTE:: /api/set/:setid
exports.legoSetInformation = (req, res) =>{
    var setID = req.params.setid;
    res.send(`NOT IMPLEMENTED YET Set information ${setID}`)
};

//Post user wants set with id :setid   ROUTE:: /api/set/wants/:setid
exports.wantsLegoSet = (req, res) => {
    var setID = req.params.setid;
    res.send(`NOT IMPLEMENTED YET wants Set ${setID}`);
};

//Post user owns set with id :setid   ROUTE:: /api/set/owns/:setid
exports.ownsLegoSet = (req, res) => {
    var setID = req.params.setid;
    res.send(`NOT IMPLEMENTED YET owns Set ${setID}`);
};
