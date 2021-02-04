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

//Post user wants lego brick with id :brickid ROUTE:: /api/brick/wants?id=id
exports.wantsLegoBrick = (req, res) => {
    var brickID = req.query.id;
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20),req.user);
        request.input('LegoBrick', sql.VarChar(20), brickID);
        request.input('Quantity', sql.Int, req.body.quantity);
        request.execute('insert_WantsBrick', (err, _)=>{
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Wants added sucessfully', 
             });
        })
    })
    
};

//Post user owns lego brick with id :brickid   ROUTE:: /api/brick/owns?id=id
exports.ownsLegoBrick = (req, res) => {
    var brickID = req.query.id;
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20),req.user);
        request.input('LegoBrick', sql.VarChar(20), brickID);
        request.input('Quantity', sql.Int, req.body.quantity);
        request.input('QuantityInUse', sql.Int, req.body.quantityInUse);
        request.execute('insert_OwnsIndividualBrick', (err, _)=>{
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Owns added sucessfully', 
             });
        })
    })
};

 //Get the Owned Bricks from a user  ROUTE:: /api/brick/owns
 exports.getOwnedBricks = (req, res) =>{
     sql.connect(config, (err)=>{
         if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
         }
         const request = new sql.Request();
         request.input('userName', sql.VarChar(20), req.user);
         request.execute('getOwnedBricks', (err, rs) =>{
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
            }
            res.json({
                data: rs.recordset
            });
         });
     })
 }
  //Get the wanted Bricks from a user  ROUTE:: /api/brick/wants
  exports.getWantedBricks = (req, res) =>{
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }
        const request = new sql.Request();
        request.input('userName', sql.VarChar(20), req.user);
        request.execute('getWantedBricks', (err, rs) =>{
           if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           res.json({
               data: rs.recordset
           });
        });
    })
}