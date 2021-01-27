/***
 * User API Controller
 * 
 */

 //dotenv for process variables
 require('dotenv').config();

 //tedious will be used for database connection
var sql = require("mssql");
var config = require('./DbConfig').config;
//bcrypt for password hashing
var bcrypt = require('bcrypt');

//Json web tokens for session
var jwt = require('jsonwebtoken');

var attempts = require('../middleware/loginAttempt').attempts;


 //creates new user ROUTE:: /api/users/create
 exports.createUser = (req, res) => {
    console.log(req.body);
    sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(400).send("database connection error");
         return;
      }else{
         const request = new sql.Request();
         request.input('Username', sql.VarChar(20), req.body.username);
         bcrypt.hash(req.body.password, 13, (err, hash) => {
            if(err){
               res.status(401).send("error in creating user");
               return;
            }
            request.input('Password', sql.NVarChar(70), hash);
            request.execute('insert_User', (err, _) => {
               if(err){
                  res.status(403).json({error: "Error creating the user, please try again"});
                  console.log(err);
                  return;
               }
               res.json({
                  message: 'user created sucessfully', 
                  user: req.body.username,
                  token: jwt.sign(req.body.username, process.env.API_TOKEN_SECRET)});
            });

         });
      }
    });
 }

 //Sign in user  ROUTE:: /api/users/login
 exports.loginUser = (req, res) => {
   var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
   sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(400).send("database connection error");
      }else{
         console.log(req.body);
         const request = new sql.Request();
         request.input('Username', sql.VarChar(20), req.body.username);
         request.execute('login_User', (err, result) => {
            if(err){
               res.status(403).json({error: "Error attempting to login the user, please try again"});
               console.log(err);
               return;
            }
            const hashedPass = result.recordset[0].hashpassword;
            bcrypt.compare(req.body.password, hashedPass, (err, same) => {
               if(err || !same){
                  res.status(403).json({error: "Unable to verify credentials"});
                  return;
               }
               attempts[ip] = {count: 0};
               
               res.json({
                  message: "Signed in successfully",
                  token: jwt.sign(req.body.username, process.env.API_TOKEN_SECRET),
                  user: req.body.username
               });
               return;
            });
         });
      }
    });
    //res.send('NOT IMPLEMENTED YET login user');
 }

 //Update password ROUTE:: /api/users/updatePassword
 exports.updateUserPassword = (req, res) => {
    res.send('NOT IMPLEMENTED YET update password');
 }

 //Delete user ROUTE:: /api/users/delete
 exports.deleteUser = (req, res) => {
    res.send('NOT IMPLEMENTED YET delete user');
 }