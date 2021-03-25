const functions = require("firebase-functions");
const { firestore, messaging } = require("../admin");

/**
 * @type {functions.HttpsFunction}
 */
module.exports = async (req, res) => {
  const userId = req.headers["x-user-id"];

  // NOTIFICATIONS
  const requesterRegistrationData = (
    await firestore.collection("registrations").doc(userId).get()
  ).data();
  if (!requesterRegistrationData) {
    return res.status(400).send("Could not find user registration");
  }

  /**
   * @type {import('firebase-admin').messaging.Message}
   */
  const message = {
    notification: {
      title: `You has requested a booking!`,
      body: "Tap to see more details",
    },
    token: requesterRegistrationData.token,
  };

  messaging.send(message).then(() => {
    res.status(200).send({ message: "Okay!" });
  });
};
