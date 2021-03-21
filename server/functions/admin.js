const admin = require("firebase-admin");

const app = admin.initializeApp();

const firestore = app.firestore();
const messaging = app.messaging();

module.exports = { firestore, messaging };
