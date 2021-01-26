/***
 * User API Controller
 * 
 */

 //dotenv for process variables
 require('dotenv').config();

 //tedious will be used for database connection
var sql = require("mssql");

//bcrypt for password hashing
var bcrypt = require('bcrypt');


 var config = {
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    server: process.env.DATABASE_URL,
    database: process.env.DATABASE_NAME
 }

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
            request.execute('insert_User', (err, result) => {
               if(err){
                  res.status(403).json({error: "Error creating the user, please try again"});
                  return;
               }console.log(result);
               res.json({message: 'user created sucessfully', user: req.body.username});
            });

         });
      }
    });
 }

 //Sign in user  ROUTE:: /api/users/login
 exports.loginUser = (req, res) => {
    sql.connect(config, (err) => {
      if(err){
         console.log(err);
         res.status(400).send("database connection error");
      }else{
         res.send("Successfully connected");
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