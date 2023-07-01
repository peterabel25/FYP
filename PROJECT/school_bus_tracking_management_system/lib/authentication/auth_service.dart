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
  try {
    final credential = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    final currentUserUid = credential.user!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('userRecords')
        .doc(currentUserUid)
        .get();
    final userRole = snapshot['role'];

    if (userRole == 'parent') {
      final PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Homepage()),
        );
      } else {
        throw Exception('Location permission not granted');
      }
    } else if (userRole == 'driver') {
      final PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => DriverHomepage()),
        );
      } else {
        throw Exception('Location permission not granted');
      }
    }

    return _userFromFirebase(credential.user);
  } catch (e) {
    // Handle any exceptions here
    print('Sign in failed: $e');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign In Failed'),
        content: const Text('An error occurred while signing in. Please try again.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return null;
  }
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


Future<void> changePassword(String newPassword, BuildContext context) async {
  try {
    final user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updatePassword(newPassword);
      print('Password changed successfully');
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    print('Failed to change password: $e');
    // Show error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to change password: $e'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


//forgot password

void sendPasswordResetEmail(String email, BuildContext context) async {
  try {
    await auth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // print('Password reset email sent');
  } catch (e) {
    print('Failed to send password reset email: $e');
    // Show error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to send password reset email: $e'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

  // void sendPasswordResetEmail(String email) async {
  //   try {
  //     await auth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     // print('Password reset email sent');
  //   } catch (e) {
  //     //  print('Failed to send password reset email: $e');
  //   }
  // }

//METHOD TO LOGOUT
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
