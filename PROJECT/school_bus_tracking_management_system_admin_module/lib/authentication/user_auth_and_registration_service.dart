// ignore_for_file: avoid_print, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/usermodal.dart';

import '../user_management/database.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';


class AuthService with ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  String loginError = "";
  String userRegistrationError = "";

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//function to delete a user
  Future<void> deleteRegisteredUser(String email, String password) async {
    try {
      auth.UserCredential credential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.delete();

      print('User deleted from Firebase Authentication successfully.');
    } catch (e) {
      print('Failed to delete user from Firebase Authentication: $e');
    }
  }
//DELETE USER RECORD
  Future<void> deleteUserData(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(userId)
          .delete();
      print('User data deleted successfully.');
    } catch (e) {
      print('Failed to delete user data: $e');
    }
  }

//LOGIN
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credential.user);
    notifyListeners();
  }

//Function for user to logout of the system
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

//Function for Admin to register in to the system

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credential.user);
  }




//Function to register driver into the system

  Future<User?> createDriverWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String licenseNo,
    required String contact,
    required String email,
    required String password,
    required String busAssigned,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



      await UserDatabaseService(uid: credential.user!.uid).createDriverRecord(
        busAssigned: busAssigned,
        contact: contact,
        email: email,
        firstName: firstName,
        lastName: lastName,
        licenseNo: licenseNo,
        password: password,
      );

    await credential.user!.sendEmailVerification();

      return _userFromFirebase(credential.user);
    } catch (error) {
      // Handle specific exceptions here
      if (error is auth.FirebaseAuthException) {
        // Handle FirebaseAuthException
        userRegistrationError = error.message!;
        print('FirebaseAuthException: ${error.message}');
      } else {
        // Handle other types of exceptions
        print('Error: $error');
      }

      return null;
    }
    notifyListeners();
  }

  // Future<User?> createDriverWithEmailAndPassword(
  //     {required String firstName,
  //     required String lastName,
  //     required String licenseNo,
  //     required String contact,
  //     required String email,
  //     required String password,
  //     required String busAssigned}) async {
  //   final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);

  //   await UserDatabaseService(uid: credential.user!.uid).createDriverRecord(
  //       busAssigned: busAssigned,
  //       contact: contact,
  //       email: email,
  //       firstName: firstName,
  //       lastName: lastName,
  //       licenseNo: licenseNo,
  //       password: password);
  //   return _userFromFirebase(credential.user);
  // }

//Function to register parent and student
  Future<User?> createParentWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String contact,
    required String email,
    required String password,
    required String studentFname,
    required String studentClass,
    required String residence,
    required String busAssigned,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserDatabaseService(uid: credential.user!.uid).createParentRecord(
        firstName: firstName,
        lastName: lastName,
        contact: contact,
        email: email,
        password: password,
        studentFname: studentFname,
        studentClass: studentClass,
        residence: residence,
        busAssigned: busAssigned,
      );

      return _userFromFirebase(credential.user);
    } catch (error) {
      // Handle specific exceptions here
      if (error is auth.FirebaseAuthException) {
        // Handle FirebaseAuthException
        userRegistrationError = error.message!;
        print('FirebaseAuthException: ${error.message}');
      } else {
        // Handle other types of exceptions
        //userRegistrationError = error.toString;
        print('Error: $error');
      }

      return null;
    }
    notifyListeners();
  }

  // Future<User?> createParentWithEmailAndPassword(
  //     {required String firstName,
  //     required String lastName,
  //     required String contact,
  //     required String email,
  //     required String password,
  //     required String studentFname,
  //     // required String studentLname,
  //     required String studentClass,
  //     required String residence,
  //     // required String pickuppoint,
  //     required String busAssigned}) async {
  //   final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);

  //   await UserDatabaseService(uid: credential.user!.uid).createParentRecord(
  //       firstName: firstName,
  //       lastName: lastName,
  //       contact: contact,
  //       email: email,
  //       password: password,
  //       studentFname: studentFname,
  //       // studentLname: studentLname,
  //       studentClass: studentClass,
  //       residence: residence,
  //       // pickuppoint: pickuppoint,
  //       busAssigned: busAssigned);
  //   return _userFromFirebase(credential.user);
  // }

//function to update user data
  Future<void> updateUserData(
    String userId,
    String firstName,
    String lastName,
    String email,
    String contact,
    String residence,
    String busAssigned,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(userId)
          .update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'contact': contact,
        'residence': residence,
        'busAssigned': busAssigned,
      });
      print('User data updated successfully');
    } catch (e) {
      print('Failed to update user data: $e');
    }
  }

  Future<void> updateDriverData(
    String userId,
    String firstName,
    String lastName,
    String email,
    String contact,
    // String residence,
    String busAssigned,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(userId)
          .update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'contact': contact,
        // 'residence': residence,
        'busAssigned': busAssigned,
      });
      print('User data updated successfully');
    } catch (e) {
      print('Failed to update user data: $e');
    }
  }
}
