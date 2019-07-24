import functions = require('firebase-functions');
import admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const db = admin.database()

// Create  User Function
exports.createUserAccount = functions.auth.user().onCreate((event) => {
    const uid = event.uid
    const email = event.email
    const full_name = event.displayName || 'New User'
    const created = event.metadata.creationTime
    const newUserRef = db.ref(`users/`).child(uid)
    
    return newUserRef.set({
        email: email,
        full_name: full_name,
        regimental: 'PD99999',
        location: 'Work Location',
        created: created,
        uid: uid
    }) 
})
