// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class AuthService{
//   // get instance of firebase auth
//   final FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
//   // get current user
// User? getCurrentUser(){
//   return _firebaseAuth.currentUser;
// }
//
//   // sign up
// Future<UserCredential> signInWithEmailPassowrd(String email,password) async{
//   try{
//     // try sign in user
//     UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     return userCredential;
//   }
//   // catch any error
//   on FirebaseAuthException catch (e){
//     throw Exception(e.code);
//   }
// }
//   // sign out
//   Future<UserCredential> signUpWithEmailPassowrd(String email,password) async{
//     try{
//       // try sign up user
//       UserCredential userCredential =
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return userCredential;
//     }
//     // catch any error
//     on FirebaseAuthException catch (e){
//       throw Exception(e.code);
//     }
//   }
//   // sign out
//   Future<void> signOut() async {
//   return await _firebaseAuth.signOut();}
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, String password, String username) async {
    try {
      // try sign up user
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // after sign up, store user info in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'username': username, // Additional information you want to store
        'createdAt': Timestamp.now(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      // try sign in user
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
