const functions = require("firebase-functions");
const { validationResult } = require("express-validator");
const { messaging } = require("../admin");

/**
 * @type {functions.HttpsFunction}
 */
module.exports = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const token = req.body.token;
  /**
   * @type {import('firebase-admin').messaging.Message}
   */
  const message = {
    notification: {
      title: `John Doe has requested a booking!`,
      body: "Tap to see more details",
    },
    token: token,
  };
  messaging.send(message).then(() => {
    res.status(200).send({ message: "Okay!" });
  });
};
