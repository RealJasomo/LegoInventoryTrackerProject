/***
 * Lego Inventory Tracker REST api
 */
//Imports
var express = require('express');
var morgan = require('morgan');
var cors = require('cors');
var helmet = require('helmet');

//Application
var app = express();
const port = process.env.PORT || 3001;
//Middleware
app.use(morgan('common'));
app.use(cors());
app.use(helmet());

//Routes 
app.get('/', (req, res) => {
    console.log(req);
    res.json({ message:"working", status:200});
});

//listener
app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`);
});
