/***
 * Lego Brick API Controller
 * 
 */

 //tedious will be used for database connection
 var sql = require("mssql");
 var config = require('./DbConfig').config;


//return all lego bricks ROUTE:: /api/bricks/
exports.legoBricksList = (req, res) => {
    sql.connect(config, (err) => {
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.query('SELECT TOP(1000) ID, ImageURL, Name, Color FROM LegoBrick', (err, rs) => {
            if(err)
                console.log(err);
            res.json({data:rs.recordset});
            return;
        });
    });
};

//return count :count lego bricks of page :page   ROUTE:: /api/bricks/:page/:count
exports.legoBricksListByPageCount = (req, res) => {
    var page = req.params.page;
    var count = req.params.count;
    sql.connect(config, (err) =>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('targetPage', sql.Int, page);
        request.input('itemsPerPage', sql.Int, count);
        request.execute('getPaginatedBricks', (err, rs) =>{
            if(err){
                res.status(500).json({error: "Error getting bricks"});
                console.log(err);
                return;
             }
             res.json({
                 data: rs.recordset
             });
        })
    })
};

//return brick information with id :brickID ROUTE:: /api/brick?id=id
exports.legoBrickInformation = (req, res) =>{
    var brickID = req.query.id;
    sql.connect(config, (err) => {
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('id', sql.VarChar(20), brickID);
        request.query('SELECT ID, ImageURL, Name, Color FROM LegoBrick WHERE ID=@id', (err, rs) =>{
            if(err){
                res.status(500).json({error: "Error getting brick; brick could not be found"});
                console.log(err);
                return;
            }
            res.json({
                data: rs.recordset
            });
        })
    })
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
