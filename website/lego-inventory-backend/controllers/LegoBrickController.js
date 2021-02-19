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
    var brickID = req.query.id
    //var brickID = req.body.favID
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
        request.input('QuantityInUse', sql.Int, req.body.quantityInUse || 0);
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
                data: rs.recordset,
                message: 'bricks collected successfully', 
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

exports.brickSearch = (req, res) =>{
    //setName = req.body.name;
    brickName = req.params.name
    searchType = req.body.type
    //console.log(setName);
    console.log(req.body);
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }

        const request = new sql.Request();
        if(searchType === 0){
            request.input('targetName', sql.VarChar(80), req.body.name);
        request.execute('searchBricks', (err, rs) =>{
           if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           //console.log(rs);
           res.json({
               data: rs.recordset
           });
        });
        }

        if(searchType === 1){
            request.input('targetID', sql.VarChar(20), req.body.name);
        request.execute('searchBricksID', (err, rs) =>{
           if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           //console.log(rs);
           res.json({
               data: rs.recordset
           });
        });
        }

        else if(searchType === 2){
            request.input('targetColor', sql.VarChar(30), req.body.name);
        request.execute('searchBricksColor', (err, rs) =>{
           if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           //console.log(rs);
           res.json({
               data: rs.recordset
           });
        });
        }
        else if(searchType === 3){
            request.input('userName', sql.VarChar(20), req.user);
            request.input('setID', sql.VarChar(20), req.body.name);
            request.execute('bricksNeededForSet', (err, rs) =>{
               if(err){
                   res.status(500).json({error: err});
                   console.log(err);
                   return;
               }
               res.json({
                   data: rs.recordset
               });
            });
        }

        else{
            //res.status(500).json({error: "bad type input"});
        }
        
    })

        
    
}


exports.updateFavoriteBrick = (req, res) =>{
    sql.connect(config, (err) => {
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20) ,req.user);
        request.input('LegoBrick', sql.VarChar(20),req.body.id);
        request.input('Quantity', sql.Int,req.body.quantity);
        request.execute('update_WantsBrick', (err, _) =>{
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Want updated sucessfully', 
             });
        });
    })
}

exports.deleteFavoriteBrick = (req,res) => {
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', req.user);
        request.input('LegoBrick', req.body.id);
        request.execute('delete_WantsBrick', (err, _) => {
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Want deleted sucessfully', 
             });
        })
    })
}

exports.updateOwnedBrick = (req,res) => {
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20), req.user);
        request.input('LegoBrick', sql.VarChar(20), req.body.id);
        request.input('Quantity', sql.Int, req.body.quantity);
        request.input('QuantityInUse', sql.Int, req.body.quantityInUse);
       
        request.execute('update_OwnsIndividualBrick', (err, _) => {
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Owned brick updated sucessfully', 
             });
        })
    })
}

exports.deleteOwnedBrick = (req,res) => {
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', req.user);
        request.input('LegoBrick', req.body.id);
        request.execute('delete_OwnsIndividualBrick', (err, _) => {
            if(err){
                res.status(500).json({error: err});
                console.log(err);
                return;
             }
             res.json({
                message: 'Owned brick deleted sucessfully', 
             });
        })
    })
}

exports.getAvailableBricks = (req, res) =>{
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }
        const request = new sql.Request();
        request.input('username', sql.VarChar(20), req.user);
        request.execute('getAvailableBricks', (err, rs) =>{
           if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           res.json({
               data: rs.recordset,
               message: 'bricks collected successfully', 
           });
        });
    })
}