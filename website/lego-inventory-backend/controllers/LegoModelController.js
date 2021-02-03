/***
 * Lego Model API Controller
 * 
 */

 //tedious will be used for database connection
 var sql = require("mssql");
 var config = require('./DbConfig').config;

 //return all lego Models ROUTE:: /api/models/
exports.legoModelsList = (req, res) => {
    sql.connect(config, (err) => {
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.query('SELECT TOP(1000) ID, ImageURL, Name, SetID FROM LegoModel', (err, rs) => {
            if(err)
                console.log(err);
            res.json({data:rs.recordset});
            return;
        });
    });
};

//return count :count lego Models of page :page   ROUTE:: /api/models/:page/:count
exports.legoModelsListByPageCount = (req, res) => {
    var page = req.params.page;
    var count = req.params.count;
    res.send(`NOT IMPLEMENTED YET Models page ${page} of ${count} Models per page`);
};

//return included lego brick ids and quantities  for model with id :modelid ROUTE:: /api/model/:modelid/includes
exports.legoModelIncludes = (req, res) => {
    var modelID = req.params.modelid;
    res.send(`NOT IMPLEMENTED YET model ${modelID} includes ....`);
};

//Post user own model with id :modelid ROUTE:: /api/model/:modelid
exports.legoModelInformation = (req, res) =>{
    var modelID = req.params.modelid;
    res.send(`NOT IMPLEMENTED YET Model information ${modelID}`)
};

//Post user builds model with id :modelid   ROUTE:: /api/model/build/:modelid
exports.buildsLegoModel = (req, res) => {
    var modelID = req.params.modelid;
    res.send(`NOT IMPLEMENTED YET builds Model ${modelID}`);
};
