const jwt = require("jsonwebtoken");
require("dotenv").config();

exports.authorize = (req, res, next) => {
  var authheader = req.headers["authorization"];
  if (authheader) {
    const token = authheader.split(" ")[1];
    jwt.verify(token, process.env.API_TOKEN_SECRET, (err, data) => {
      if (err) {
        res.status(403).send("Invalid token");
        return;
      }
      req.user = data;
      next();
    });
  } else {
    res.status(403).send("Unauthorized request; please log in");
  }
};
