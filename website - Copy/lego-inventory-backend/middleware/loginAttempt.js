exports.attempts = {}
let secureEnv = require('secure-env');
//global.env = secureEnv({secret: process.env.ENC_PASS});

exports.loginAttempt = (req, res, next) =>{
    var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    var attempt = exports.attempts[ip] || {count: 0};
    ++attempt.count;
    exports.attempts[ip] = attempt;
    if(attempt.count > process.env.MAX_ATTEMPTS){
        setTimeout((attempt, ip) => {
            attempt.count = 0;
            exports.attempts[ip] = attempt;
        },process.env.ERR_TIMEOUT, attempt, ip);
        res.status(401).json({
            error:`Too many login attempts from this IP please wait`
        });
    }else{
        next();
    }
}
