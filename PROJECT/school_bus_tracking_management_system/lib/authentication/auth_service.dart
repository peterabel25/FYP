// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_conditional_assignment, non_constant_identifier_names, avoid_print
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/driver_module/driver_homepage/driver_homepage.dart';
import 'package:school_bus_tracking_management_system/parent_module/homepage/parent_homepage.dart';
import 'user_modal.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  String? currentUserUid;

// CHECK AUTH STATE OF THE USER
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  String? get getCurrentUserUid => currentUserUid;

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//METHOD TO SIGNIN A USER WITH EMAIL AND PASSWORD
  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    currentUserUid = credential.user!.uid;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('userRecords')
        .doc(currentUserUid)
        .get();
    String userRole = snapshot['role'];
    if (userRole == 'parent') {
      final PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: ((_) => Homepage())));
      }
    } else if (userRole == 'driver') {
      final PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((_) => DriverHomepage())));
      }
    }

    return _userFromFirebase(credential.user);
  }

//METHOD TO SEND EMERGENCIES
  void SendEmergency(String dropdownValue, String description) {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentReference parentDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(uid);

      CollectionReference messagesCollectionRef =
          parentDocRef.collection('messages');

      // Create a new message document
      Map<String, dynamic> newMessage = {
        'messageBody': description,
        'Title': dropdownValue,
        'sender': uid,
        'timestamp': FieldValue.serverTimestamp(),
      };

      messagesCollectionRef.add(newMessage);
      parentDocRef.update({'isAbsent': true});
    }
  }

//METHOD TO SEND EMERGENCY
  void driverEmergency(String dropdownValue, String description) {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentReference driverDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(uid);

      CollectionReference messagesCollectionRef =
          driverDocRef.collection('messages');

      // Create a new message document
      Map<String, dynamic> newMessage = {
        'messageBody': description,
        'Title': dropdownValue,
        'sender': uid,
        'timestamp': FieldValue.serverTimestamp(),
      };

      messagesCollectionRef.add(newMessage);
    }
  }

//CHANGE PASSWORD

  Future<void> changePassword(String newPassword) async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        print('Password changed successfully');
      } catch (e) {
        print('Failed to change password: $e');
      }
    }
  }

//forgot password
  void sendPasswordResetEmail(String email) async {
    try {
      await auth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // print('Password reset email sent');
    } catch (e) {
      //  print('Failed to send password reset email: $e');
    }
  }

//METHOD TO LOGOUT
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
