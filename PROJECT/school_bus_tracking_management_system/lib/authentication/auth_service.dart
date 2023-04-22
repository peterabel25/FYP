// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
//import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/driver_module/driver_homepage/driver_homepage.dart';
import 'package:school_bus_tracking_management_system/parent_module/homepage/homepage.dart';
import 'user_modal.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  String? currentUserUid;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  //String? get currentUserUid => _currentUserUid;
  String? get getCurrentUserUid => currentUserUid;

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//Function for user to login to the system
  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    currentUserUid = credential.user!.uid;
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

    return _userFromFirebase(credential.user);
  }



void checkUser(){
  auth.User? user = auth.FirebaseAuth.instance.currentUser;

if (user != null) {
  String uid = user.uid;

  print('UID: $uid');
} else {
  print('No user is currently authenticated');
}

}

//Function for user to logout of the system
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
