const jwt = require("jsonwebtoken");
let secureEnv = require('secure-env');
global.env = secureEnv({secret: process.env.ENC_PASS});

exports.authorize = (req, res, next) => {
    var authheader = req.headers['authorization'];
    if(authheader){
        const token = authheader.split(' ')[1];
        jwt.verify(token, global.env.API_TOKEN_SECRET, (err, data) => {
            if(err){
                res.status(403).send("Invalid token");
                return;
            }
            req.user = data;
            next();
        });
    }else{
        res.status(403).send('Unauthorized request; please log in');
    }
}