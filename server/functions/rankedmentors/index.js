const functions = require("firebase-functions");
const express = require("express");
const requireUserId = require("../middleware/require-user-id");
const get = require("./get");

const rankedMentors = express();

rankedMentors.get("/", requireUserId, get);

/**
 * @type {functions.HttpsFunction}
 */
module.exports = functions.https.onRequest(rankedMentors);
