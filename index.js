'use strict'
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.database.ref('/notifications/{user_id}/{notifications_id').onWrite(event => {
const user_id = event.params.user_id;
const notifications_id = event.params.notifications_id;

console.log('User Id: ', user_id);

});