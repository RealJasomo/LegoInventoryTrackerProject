/***
 * Lego Inventory Tracker REST api
 * 
 * Created by: Jason Cramer, Jamari Morrison, and Luke Ferderer
 */

//Imports
var express = require('express');
var morgan = require('morgan');
var cors = require('cors');
var helmet = require('helmet');
var bodyParser = require('body-parser');
//api
var api = require('./api.js');

//Application
var app = express();



const port = process.env.PORT || 3001;
//Middleware
app.use(morgan('common'));
app.use(cors());
app.use(helmet());
app.use('/api',api);

//Routes 
app.get('/', (req, res) => {
   
    console.log(req);
    res.json({ message:"working", status:200});
});

//listener
app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`);
});

