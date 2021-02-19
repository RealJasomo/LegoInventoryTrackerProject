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

//password validator
var passwordValidator = require('password-validator');

var attempts = require('../middleware/loginAttempt').attempts;

//Password validation schema
var passwordSchema  = new passwordValidator();
passwordSchema
.is().min(6) // minimum of 6 characters
.has().uppercase() //at least one uppercase character
.has().lowercase() //at least one lowercase
.has().digits() //at least one number
.has().symbols() //at least one symbol

 //creates new user ROUTE:: /api/users/create
 exports.createUser = (req, res) => {
    console.log(req.body);
    if(!checkPassword(req.body.password, res)){
      console.log('password fails');
      return;
    }
    sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(500).send("database connection error");
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
   if(!checkPassword(req.body.newPassword, res)){
      return;
    }
    sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(500).send("database connection error");
         return;
      }
      var request = new sql.Request();
      request.input('Username', sql.VarChar(20), req.user);
      request.execute('login_User', (err, result) => {
         if(err){
            res.status(403).json({error: "Error attempting to login the user, please try again"});
            console.log(err);
            return;
         }
         const hashedPass = result.recordset[0].hashpassword;
         bcrypt.compare(req.body.oldPassword, hashedPass, (err, same) => {
            if(err || !same){
               res.status(403).json({error: "Unable to verify credentials"});
               return;
            }
            request = new sql.Request()
            request.input('Username', sql.VarChar(20), req.user);
            bcrypt.hash(req.body.newPassword, 13, (err, hash) => {
               if(err){
                  console.log(err);
                  res.status(500).json({error: err});
                  return;
               }
               request.input('Password', sql.NVarChar(70), hash);
               request.execute('update_User', (err, _) => {
                  if(err){
                     res.status(500).json({error: err});
                     console.log(err);
                     return;
               }
               res.json({
                     message: "sucessfully updated password"
               });
               })
            });
         });
      })
      }) 
 }

 //Delete user ROUTE:: /api/users/delete
 exports.deleteUser = (req, res) => {
   sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(500).send("database connection error");
         return;
      }
      const request = new sql.Request()
      request.input('Username', sql.VarChar(20), req.user);
      request.execute('delete_User', (err, _) => {
            if(err){
               res.status(500).json({error: err});
               console.log(err);
               return;
           }
           res.json({
               message: "sucessfully deleted account"
           });
         })
      
    });
 }


 checkPassword = (password, res) =>{
    console.log(password);
    var errors = passwordSchema.validate(password, {list: true});
    console.log(errors);
    if(errors.length > 0){
       var err = errors.map(err => {switch(err){
            case 'min': return "The password must have at least 6 characters"
            case 'uppercase': return "The password must have at least one uppercase value."
            case 'lowercase': return "The password must have at least one lowercase value."
            case 'digits': return "The password must have at least one digit."
            case 'symbols': return "The password must contain at least one special character."
       }
      }).join('\n');
      res.status(500).send({error: err});
      return false;
    }
    return true;
 }