importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js');

// Your web app's Firebase configuration
const firebaseConfig = {
  		  apiKey: "AIzaSyDke7gQNq9KzXpYrrl7zwMzJI1iYjgylAo",
		  authDomain: "onepick-2a02e.firebaseapp.com",
		  databaseURL: "https://onepick-2a02e-default-rtdb.asia-southeast1.firebasedatabase.app",
		  projectId: "onepick-2a02e",
		  storageBucket: "onepick-2a02e.appspot.com",
		  messagingSenderId: "1000997640667",
		  appId: "1:1000997640667:web:71eb0c5f76d972d5652ffe",
		  measurementId: "G-F1F2D8M1Y4"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Initialize Firebase Cloud Messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Received background message ', payload);
  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

