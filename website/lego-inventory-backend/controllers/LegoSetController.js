/***
 * Lego Set API Controller
 * 
 */

 //tedious will be used for database connection
 var sql = require("mssql");
 var config = require('./DbConfig').config;

  //return all lego Sets ROUTE:: /api/sets/
exports.legoSetsList = (req, res) => {
    //res.send('NOT IMPLEMENTED YET all Set informations');
    sql.connect(config, (err) => {
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.query('SELECT TOP(1000) ID, ImageURL, Name FROM LegoSet', (err, rs) => {
            if(err)
                console.log(err);
            res.json({data:rs.recordset});
            return;
        });
    });
};

//return count :count lego Sets of page :page   ROUTE:: /api/sets/:page/:count
exports.legoSetsListByPageCount = (req, res) => {
    var page = req.params.page;
    var count = req.params.count;
    //res.send(`NOT IMPLEMENTED YET Sets page ${page} of ${count} Sets per page`);
    sql.connect(config, (err) =>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('targetPage', sql.Int, page);
        request.input('itemsPerPage', sql.Int, count);
        request.execute('getPaginatedSets', (err, rs) =>{
            if(err){
                res.status(500).json({error: "Error getting sets"});
                console.log(err);
                return;
             }
             res.json({
                 data: rs.recordset
             });
        })
    })
};



//return included lego brick ids and quantities  for set with id :setid ROUTE:: /api/set/:setid/includes
exports.legoSetIncludes = (req, res) => {
    var setID = req.params.setid;
    // res.send(`NOT IMPLEMENTED YET set ${setID} includes ....`);
    sql.connect(config, (err) =>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('SetID', sql.VarChar(20), setID);
        request.execute('SetContents', (err, rs) =>{
            if(err){
                res.status(500).json({error: "Error getting sets"});
                console.log(err);
                return;
             }
             res.json({
                 data: rs.recordset
             });
        })
    })
};

//Post user own set with id :setid ROUTE:: /api/set/:id
exports.legoSetInformation = (req, res) =>{
    var setID = req.params.setid;
    res.send(`NOT IMPLEMENTED YET Set information ${setID}`)
};

//Post user wants set with id :setid   ROUTE:: /api/set/wants/:id
exports.wantsLegoSet = (req, res) => {
    //var setID = req.params.id;
    setID = req.body.id;
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20),req.user);
        request.input('LegoSet', sql.VarChar(20), setID);
        request.input('Quantity', sql.Int, req.body.quantity);
        
        request.execute('insert_WantsSet', (err, _)=>{
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

//Post user owns set with id :setid   ROUTE:: /api/set/owns/:id
exports.ownsLegoSet = (req, res) => {
    //var setID = req.params.id;
    console.log(req.body);
    sql.connect(config, (err)=>{
        if(err){
            console.log(err);
            res.status(500).send("database connection error");
            return;
        }
        const request = new sql.Request();
        request.input('Username', sql.VarChar(20),req.user);
        request.input('LegoSet', sql.VarChar(20), req.body.id);
        request.input('Quantity', sql.Int, req.body.quantity);
        request.input('QuantityBuilt', sql.Int, req.body.quantityInUse);
        
        request.execute('insert_OwnsSet', (err, _)=>{
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

//Get the wanted Sets from a user  ROUTE:: /api/set/wants
exports.getWantedSets = (req, res) =>{
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }
        const request = new sql.Request();
        request.input('userName', sql.VarChar(20), req.user);
        request.execute('getWantedSets', (err, rs) =>{
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

 //Get the Owned sets from a user  ROUTE:: /api/set/owns
 exports.getOwnedSets = (req, res) =>{
    console.log('works');
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }
        const request = new sql.Request();
        request.input('userName', sql.VarChar(20), req.user);
        request.execute('getOwnedSets', (err, rs) =>{
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

//Search for a set using a keyword  ROUTE:: /api/set/search/:name
exports.setSearch = (req, res) =>{
    //setName = req.body.name;
    setName = req.params.name
    console.log(setName);
    sql.connect(config, (err)=>{
        if(err){
           console.log(err);
           res.status(500).send("database connection error");
           return;
        }
        const request = new sql.Request();
        request.input('targetName', sql.VarChar(80), req.body.name);
        request.execute('searchSets', (err, rs) =>{
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
