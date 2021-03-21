const functions = require("firebase-functions");
const { firestore, messaging } = require("../admin");
const { validationResult } = require("express-validator");

/**
 * @type {functions.HttpsFunction}
 */
module.exports = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const userId = req.headers["x-user-id"];
  const bookingId = req.params.bookingId;

  const bookingRef = firestore.collection("bookings").doc(bookingId);

  const bookingDataRef = await bookingRef.get();
  if (!bookingDataRef.exists) {
    return res.status(400).send(`Booking ID ${bookingId} doesn't exist`);
  }

  const oldBookingData = bookingDataRef.data();
  const { status, date, preferredCallProvider } = req.body;
  let changelog = { requesterId: oldBookingData.requesterId };
  let newBookingData = { ...oldBookingData };

  if (status === "accepted" || status === "rejected") {
    if (oldBookingData.status === status) {
      return res.status(400).send(`Booking status is already '${status}'`);
    }
    if (userId === oldBookingData.requesterId && status === "accepted") {
      // the requester can't be the one to accept
      return res.status(400).send(`Can't accept your own booking request`);
    }

    changelog.status = oldBookingData.status;

    newBookingData = {
      ...oldBookingData,
      status,
      requesterId: userId,
      changelog: [...(oldBookingData.changelog || []), changelog],
    };
  } else {
    // Editing or challenging booking
    if (
      oldBookingData.date === date &&
      oldBookingData.preferredCallProvider === preferredCallProvider
    ) {
      return res.status(400).send("Nothing changed");
    }
    if (oldBookingData.date !== date) {
      changelog.date = oldBookingData.date;
    }
    if (oldBookingData.preferredCallProvider !== preferredCallProvider) {
      changelog.preferredCallProvider = oldBookingData.preferredCallProvider;
    }
    newBookingData = {
      ...oldBookingData,
      status: "pending",
      date,
      preferredCallProvider,
      requesterId: userId,
      changelog: [...(oldBookingData.changelog || []), changelog],
    };
  }

  await bookingRef.set(newBookingData);
  res.status(200).send({ message: "Okay!", data: newBookingData });

  // NOTIFICATIONS
  let recipientId, senderId;
  if (userId === oldBookingData.mentorId) {
    recipientId = oldBookingData.menteeId;
    senderId = oldBookingData.mentorId;
  } else {
    recipientId = oldBookingData.mentorId;
    senderId = oldBookingData.menteeId;
  }

  const senderProfile = (
    await firestore.collection("users").doc(senderId).get()
  ).data();

  const recipientRegistration = (
    await firestore.collection("registrations").doc(recipientId).get()
  ).data();
  if (!recipientRegistration) {
    return;
  }

  /**
   * @type {import('firebase-admin').messaging.Message}
   */
  const message = {
    notification: {
      title: `${senderProfile.firstName} ${senderProfile.lastName} has responded`,
      body: "Tap to see your booking",
    },
    token: recipientRegistration.token,
  };

  messaging.send(message);
};
