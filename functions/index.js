const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();

exports.notifyNewMessage = functions.firestore
    .document('UserNotification/{userDocid}')

    .onCreate(async snapshot => {
        const message = snapshot.data();
       
       

       
        const querySnapshot = await db
            .collection('Users')
            .doc(message.userDocid)
            .collection('tokens')   
            .get();

        const tokens = querySnapshot.docs.map(snap => snap.id);

        const payload = {
            notification: {
                title: `Nisah App`,
                body: "Your Request is accepted",
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            }
        }
        return fcm.sendToDevice(tokens, payload);
   

    });

