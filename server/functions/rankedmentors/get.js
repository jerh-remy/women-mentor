const { firestore } = require("../admin");

/**
 * @type {import('firebase-functions').HttpsFunction}
 */
module.exports = async (req, res) => {
  const userId = req.headers["x-user-id"];
  const query = req.query;
  const rankedBy = query.only ? query.only.split(",") : [];

  const userRef = firestore.collection("users").doc(userId);

  const userDataRef = await userRef.get();
  if (!userDataRef.exists) {
    return res.status(400).send(`User ${userId} doesn't exist`);
  }

  const [mentorsCollection, usersCollection] = await Promise.all([
    firestore.collection("mentors").get(),
    firestore.collection("users").get(),
  ]);

  const userData = userDataRef.data();
  const usersMap = new Map([]);

  const scoredMentors = new Map([]);

  // convert collection data to map
  usersCollection.forEach((doc) => {
    if (doc.id === userId) return;
    usersMap.set(doc.id, doc.data());
  });

  // loop through all mentors and get its user data (mentorUserInfo)
  // compare mentor with user (requester) and calculate score
  mentorsCollection.forEach((doc) => {
    const mentorUserInfo = usersMap.get(doc.id);
    if (!mentorUserInfo) return;

    const mentorHobbies = mentorUserInfo.hobbies || [];
    const userHobbies = userData.hobbies || [];
    const matchedHobbies = [...mentorHobbies, ...userHobbies].filter(
      (x, i, arr) => arr.indexOf(x) !== i
    );
    const hobbiesScore = matchedHobbies.length;

    const mentorTechInterests = mentorUserInfo.techInterests || [];
    const userTechInterests = userData.techInterests || [];
    const matchedTechInterests = [
      ...mentorTechInterests,
      ...userTechInterests,
    ].filter((x, i, arr) => arr.indexOf(x) !== i);
    const techInterestsScore = matchedTechInterests.length;

    const ethnicityScore =
      mentorUserInfo.ethnicity === userData.ethnicity ? 1 : 0;

    let totalScore = 0;
    if (rankedBy.length === 0) {
      // no query, include all factors
      totalScore = hobbiesScore + techInterestsScore + ethnicityScore;
      scoredMentors.set(doc.id, totalScore);
      return;
    }
    if (rankedBy.includes("hobbies")) {
      totalScore += hobbiesScore;
    }
    if (rankedBy.includes("tech") || rankedBy.includes("techInterests")) {
      totalScore += techInterestsScore;
    }
    if (rankedBy.includes("ethnicity")) {
      totalScore += ethnicityScore;
    }

    scoredMentors.set(doc.id, totalScore);
  });

  const rankedMentors = Array.from(scoredMentors)
    .sort((a, b) => b[1] - a[1])
    .map(([docId]) => {
      return docId;
    });
  res.send({ message: "Okay!", data: rankedMentors });
};
