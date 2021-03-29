const functions = require("firebase-functions");
const { validationResult } = require("express-validator");
const { firestore, messaging } = require("../admin");

/**
 * @type {functions.HttpsFunction}
 */
module.exports = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const userId = req.headers["x-user-id"];

  const body = req.body;
  const { mentorId, menteeId, date, preferredCallProvider, purpose } = body;

  // TODO need to handle overlapping dates

  const newBookingData = {
    mentorId,
    menteeId,
    date,
    preferredCallProvider,
    purpose,
    changelog: [],
    status: "pending",
    requesterId: userId,
  };

  const mentorRef = firestore.collection("mentors").doc(mentorId);
  const menteeRef = firestore.collection("mentees").doc(menteeId);

  const mentorDataRef = await mentorRef.get();
  const menteeDataRef = await menteeRef.get();

  if (!mentorDataRef.exists) {
    return res.status(400).send(`Mentor ${mentorId} doesn't exist`);
  }
  if (!menteeDataRef.exists) {
    return res.status(400).send(`Mentee ${menteeId} doesn't exist`);
  }

  const mentorData = mentorDataRef.data();
  const menteeData = menteeDataRef.data();

  const newBooking = await firestore.collection("bookings").add(newBookingData);

  mentorRef.update({
    bookings: [...(mentorData.bookings || []), newBooking.id],
  });

  menteeRef.update({
    bookings: [...(menteeData.bookings || []), newBooking.id],
  });

  res.status(200).send({ message: "Okay!", data: newBookingData });

  // NOTIFICATIONS
  const senderProfile = (
    await firestore.collection("users").doc(menteeId).get()
  ).data();

  const recipientRegistration = (
    await firestore.collection("registrations").doc(mentorId).get()
  ).data();
  if (!recipientRegistration) {
    return;
  }

  /**
   * @type {import('firebase-admin').messaging.Message}
   */
  const message = {
    notification: {
      title: `${senderProfile.firstName} ${senderProfile.lastName} has requested a booking!`,
      body: "Tap to see more details",
    },
    data: {
      bookingId: newBooking.id,
      bookingData: newBookingData,
    },
    token: recipientRegistration.token,
  };

  messaging.send(message);
};
