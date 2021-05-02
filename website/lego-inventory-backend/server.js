/***
 * Lego Inventory Tracker REST api
 * 
 * Created by: Jason Cramer, Jamari Morrison, and Luke Ferderer
 */

//Imports
const path = require('path');
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

//app.use(helmet());
app.use(
    helmet({
      contentSecurityPolicy: false,
    })
  );
app.use('/api',api);

//added this
//change last area to the heroku URL they give
const whitelist = ['http://localhost:3001', 'http://localhost:8080', 'https://lego-inventory-tracker.herokuapp.com', `http://localhost:${port}`]
const corsOptions = {
  origin: function (origin, callback) {
    console.log("** Origin of request " + origin)
    if (whitelist.indexOf(origin) !== -1 || !origin) {
      console.log("Origin acceptable")
      callback(null, true)
    } else {
      console.log("Origin rejected")
      callback(new Error('Not allowed by CORS'))
    }
  }
}
app.use(cors(corsOptions));

//added this
//if (process.env.NODE_ENV === 'production') {
    // Serve any static files
    app.use(express.static(path.join(__dirname, 'lego-inventory-tracker/build')));
  // Handle React routing, return all requests to React app
    app.get('*', function(req, res) {
      res.sendFile(path.join(__dirname, 'lego-inventory-tracker/build', 'index.html'));
    });
 // }

//Routes 
app.get('/', (req, res) => {
   
    console.log(req);
    res.json({ message:"working", status:200});
});

//listener
app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`);
});

