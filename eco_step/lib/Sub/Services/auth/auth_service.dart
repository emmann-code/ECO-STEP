import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  // get instance of firebase auth
  final FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
  // get current user
User? getCurrentUser(){
  return _firebaseAuth.currentUser;
}

  // sign up
Future<UserCredential> signInWithEmailPassowrd(String email,password) async{
  try{
    // try sign in user
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
  // catch any error
  on FirebaseAuthException catch (e){
    throw Exception(e.code);
  }
}
  // sign out
  Future<UserCredential> signUpWithEmailPassowrd(String email,password) async{
    try{
      // try sign up user
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    }
    // catch any error
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  // sign out
Future<void> signOut() async {
  return await _firebaseAuth.signOut();
}
}