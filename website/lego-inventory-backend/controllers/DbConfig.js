let secureEnv = require('secure-env');
global.env = secureEnv({secret: process.env.ENC_PASS});
exports.config = {
    user: global.env.DATABASE_USER,
    password: global.env.DATABASE_PASSWORD,
    server: global.env.DATABASE_URL,
    database: global.env.DATABASE_NAME
 }