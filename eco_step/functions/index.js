const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const messaging = admin.messaging();

// Send notification on app launch (user creation)
exports.sendWelcomeNotification = functions.firestore
    .document("users/{userId}")
    .onCreate((snap, context) => {
      const userData = snap.data();
      const fcmToken = userData.fcmToken;
      const payload = {
        notification: {
          title: "Hey there!",
          body: "Get started.Discover ways to improve ecofriendly habits.",
        },
      };
      return messaging
          .sendToDevice(fcmToken, payload)
          .then((response) => {
            console.log("Successfully sent welcome message:", response);
          })
          .catch((error) => {
            console.log("Error sending welcome message:", error);
          });
    });

// Daily tips notification (triggered at a specific time every day)
exports.sendDailyTipsNotification = functions.pubsub.schedule("every day 09:00")
    .timeZone("America/Los_Angeles") // Adjust to the desired timezone
    .onRun(async (context) => {
      const usersSnapshot = await admin.firestore().collection("users").get();
      const payload = {
        notification: {
          title: "Daily Eco Tip!",
          body: "Start your day with a new eco-friendly habit!",
        },
      };
      const tokens = [];
      usersSnapshot.forEach((doc) => {
        const userData = doc.data();
        if (userData.fcmToken) {
          tokens.push(userData.fcmToken);
        }
      });
      return messaging
          .sendToDevice(tokens, payload)
          .then((response) => {
            console.log("Successfully sent daily tips:", response);
          })
          .catch((error) => {
            console.log("Error sending daily tips:", error);
          });
    });

// Event-specific notification (triggered when a new event is added)
exports.sendEventNotification = functions.firestore
    .document("events/{eventId}")
    .onCreate(async (snap, context) => {
      const eventData = snap.data();
      const eventTitle = eventData.title || "New Event!";
      const eventBody = eventData.description || "Join our community event!";
      const usersSnapshot = await admin.firestore().collection("users").get();
      const payload = {
        notification: {
          title: eventTitle,
          body: eventBody,
        },
      };
      const tokens = [];
      usersSnapshot.forEach((doc) => {
        const userData = doc.data();
        if (userData.fcmToken) {
          tokens.push(userData.fcmToken);
        }
      });
      return messaging
          .sendToDevice(tokens, payload)
          .then((response) => {
            console.log("Successfully sent event notification:", response);
          })
          .catch((error) => {
            console.log("Error sending event notification:", error);
          });
    });
