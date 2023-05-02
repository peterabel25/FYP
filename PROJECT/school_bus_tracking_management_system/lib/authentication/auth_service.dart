// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_conditional_assignment, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/driver_module/driver_homepage/driver_homepage.dart';
import 'package:school_bus_tracking_management_system/parent_module/homepage/homepage.dart';
import 'user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  String? currentUserUid;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  String? get getCurrentUserUid => currentUserUid;

  // Method to get the stored credentials from SharedPreferences
  Future<auth.AuthCredential?> getStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      return auth.EmailAuthProvider.credential(
          email: email, password: password);
    }
    return null;
  }

  // Method to store the user credentials in SharedPreferences
  Future<void> storeCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//Function for user to login to the system
  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    auth.AuthCredential? credential = await getStoredCredentials();
    if (credential == null) {
      credential =
          auth.EmailAuthProvider.credential(email: email, password: password);
    }
    final result = await _firebaseAuth.signInWithCredential(credential);

    currentUserUid = result.user!.uid;
    // print(currentUserUid);
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('userRecords')
        .doc(currentUserUid)
        .get();
    String userRole = snapshot['role'];
    if (userRole == 'parent') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((_) => Homepage())));
    } else if (userRole == 'driver') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((_) => DriverHomepage())));
    }

    // Store the user credentials for future use
    await storeCredentials(email, password);

    return _userFromFirebase(result.user);
  }

  // Future<User?> signInWithEmailAndPassword(
  //     BuildContext context, String email, String password) async {

  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email, password: password);

  //   currentUserUid = credential.user!.uid;

  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('userRecords')
  //       .doc(currentUserUid)
  //       .get();
  //   String userRole = snapshot['role'];
  //   if (userRole == 'parent') {
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: ((_) => Homepage())));
  //   } else if (userRole == 'driver') {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: ((_) => DriverHomepage())));
  //   }

  //   return _userFromFirebase(credential.user);
  // }

  void SendEmergency() {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(uid);

      CollectionReference messagesCollectionRef =
          parentDocRef.collection('messages');

      // Create a new message document
      Map<String, dynamic> newMessage = {
        'messageBody': 'Hello Driver!',
        'sender': uid,
        // 'timestamp': FieldValue.serverTimestamp(),
      };

      messagesCollectionRef.add(newMessage);
    }
  }

  void driverEmergency() {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentReference driverDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(uid);

      CollectionReference messagesCollectionRef =
          driverDocRef.collection('messages');

      // Create a new message document
      Map<String, dynamic> newMessage = {
        'messageBody': 'Hello Driver!',
        'sender': uid,
        // 'timestamp': FieldValue.serverTimestamp(),
      };

      messagesCollectionRef.add(newMessage);
    }
  }

//Function for user to logout of the system
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await _firebaseAuth.signOut();

    // return await _firebaseAuth.signOut();
  }
}
