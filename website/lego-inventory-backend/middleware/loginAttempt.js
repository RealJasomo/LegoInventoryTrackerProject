var attempts = {}

exports.loginAttempt = (req, res, next) =>{
    var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    var attempt = attempts[ip] || {count: 0};
    ++attempt.count;
    attempts[ip] = attempt;
    if(attempt.count > process.env.MAX_ATTEMPTS){
        setTimeout((attempt, ip) => {
            attempt.count = 0;
            attempts[ip] = attempt;
        },process.env.ERR_TIMEOUT, attempt, ip);
        res.json({
            error:`Too many login attempts from this IP please wait`
        });
    }else{
        next();
    }
}
