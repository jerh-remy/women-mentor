const express = require("express");
const { body } = require("express-validator");
const functions = require("firebase-functions");
const requireUserId = require("../middleware/require-user-id");
const patch = require("./patch");
const post = require("./post");

const bookings = express();

// Validation documentation https://github.com/validatorjs/validator.js#validators

bookings.post(
  "/",
  requireUserId,
  body("mentorId").isString(),
  body("menteeId").isString(),
  body("date").isDate(),
  body("preferredCallProvider").isString(),
  post
);

bookings.patch(
  "/:bookingId",
  requireUserId,
  body("status").isString(),
  body("date").isDate(),
  body("preferredCallProvider").isString(),
  patch
);

module.exports = functions.https.onRequest(bookings);
