/**
 * @type {import('express').RequestHandler}
 */
module.exports = (req, res, next) => {
  if (!req.headers["x-user-id"]) {
    res.status(400).send("x-user-id header missing");
  } else {
    next();
  }
};
