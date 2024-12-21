import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    //apiKey: 'AIzaSyBTgkjMupCAK20m5NNHa3uUJYZ7', //test key  
    //appId: '1:822839636936:web:24b538dcc70', //test appId
    //apiKey: 'AIzaSyBTgkjMupCAK20m5NNHa3uU',  
    apiKey: "AIzaSyBa9R4HjTdYk9UXDAAd4JDIzhWiY1tRVu0",
    appId: '1:822839636936:web:24b538dda52d426cc70',
    messagingSenderId: '82283963696',
    projectId: 'auth-f07aa',
    authDomain: 'auth-f07aa.firebaseapp.com',
    databaseURL: 'https://auth-f07aa-default-rtdb.asia-southeast1.firebasedatabase.app', // IMPORTANT!
    storageBucket: 'auth-f07aa.appspot.com',
    measurementId: 'G-PSJPSJ6GD',
/*
    apiKey: 'AIzaSyBTgkjMupCAK20m5NNHa3uUJYZ7nbdr',  
    appId: '1:822839636936:web:24b538dda52d426cc70',
    messagingSenderId: '822839636936',
    projectId: 'auth-f07aa',
    authDomain: 'auth-f07aa.firebaseapp.com',
    databaseURL: 'https://auth-f07aa-default-rtdb.asia-southeast1.firebasedatabase.app', // IMPORTANT!
    storageBucket: 'auth-f07aa.appspot.com',
    measurementId: 'G-PSJPSJ6GDM',*/
    
    
  );
}