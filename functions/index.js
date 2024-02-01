

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


exports.sendSilentNotification = functions.firestore
    .document("someCollection/{docId}")
    .onCreate((snapshot, context) => {
      // Assuming token parts are for demonstration and you have a valid token
      const token = "dk__kjXCv00ZvzOPOBTuQR:APA91bE-tdh37tabKorF-_0bHC4GflZmAKYOVmyAVP_QLsUYfPJzBlGSpX4ZMt1iIB6_KY7CcKrMaS2DieDB-i3FZPNYP7TEqs65UExma724xhKMAxsl3MdbnjbSmB8e1YTF6Ony8jZ_"

      const payload = {
        data: {
          // Your custom data here
          key1: "value1",
          key2: "value2",
        },
        apns: {
          headers: {
            "apns-priority": "5", // Ensure low priority for silent notifications
          },
          payload: {
            aps: {
              "content-available": 1,
            },
          },
        },
        android: {
          priority: "high", // Use high for immediate delivery
          data: {
            // Android-specific data can go here, if any
            "content-available": "1", // This makes it a data message for Android, which is the equivalent of a silent notification
          },
        },
        token: token,
      };

      return admin.messaging().send(payload)
          .then((response) => {
            console.log("Silent notification sent:", response);
            return null; // Ensure you return null or a value to avoid dangling promises.
          })
          .catch((error) => {
            console.error("Error sending silent notification:", error);
            return null; // Handle errors appropriately.
          });
    });



