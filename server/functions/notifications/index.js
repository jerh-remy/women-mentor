const express = require("express");
const { body } = require("express-validator");
const functions = require("firebase-functions");
const requireUserId = require("../middleware/require-user-id");
const get = require("./get");
const post = require("./post");

const notifications = express();

// Validation documentation https://github.com/validatorjs/validator.js#validators

notifications.get("/", requireUserId, get);

notifications.post("/", body("token").isString(), post);

module.exports = functions.region('europe-west2').https.onRequest(notifications);