importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
    apiKey: 'AIzaSyDfjXtchDhPc_FDSZ1p9LOxcW9Zx3iBNEM',
    authDomain: 'http://student-corner-bc4ef.firebaseapp.com/',
    databaseURL: 'https://student-corner-bc4ef.firebaseio.com',
    projectId: 'student-corner-bc4ef',
    storageBucket: 'http://student-corner-bc4ef.appspot.com/',
    messagingSenderId: '753531438374',
    appId: '1:753531438374:web:70388d77a928aa47316de7',
    measurementId: 'G-L8FWYY2BSY',
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function(payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function(event) {
    console.log('notification received: ', event)
});