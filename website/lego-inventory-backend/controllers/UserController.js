/***
 * User API Controller
 * 
 */

 //tedious will be used for database connection
 var Connection = require('tedious').Connection;

 //creates new user ROUTE:: /api/users/create
 exports.createUser = (req, res) => {
    res.send('NOT IMPLEMENTED YET create new user');
 }

 //Sign in user  ROUTE:: /api/users/login
 exports.loginUser = (req, res) => {
    res.send('NOT IMPLEMENTED YET login user');
 }

 //Update password ROUTE:: /api/users/updatePassword
 exports.updateUserPassword = (req, res) => {
    res.send('NOT IMPLEMENTED YET update password');
 }

 //Delete user ROUTE:: /api/users/delete
 exports.deleteUser = (req, res) => {
    res.send('NOT IMPLEMENTED YET delete user');
 }