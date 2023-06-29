// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls, unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:permission_handler/permission_handler.dart';

class DriverData with ChangeNotifier {
  late String driverBusNo;
  String? email;
  String? firstName;
  String? lastName;
  List<GeoPoint> pickupPoints = [];
  List<GeoPoint> emergencyPickupPoints = [];

//METHOD TO FETCH DRIVER'S DATA , PERSONAL INFO,PARENTS IN THE ROUTE ,BUS CURRENT LOCATION AND SEND IT TO DB
  Future fetchDriverData() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      //fetch driver details
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(uid)
          .get();
      driverBusNo = snapshot['busAssigned'];
      email = snapshot['email'];
      firstName = snapshot['firstName'];
      lastName = snapshot['lastName'];

      //function to fetch parents and their pickuppoint
      FirebaseFirestore.instance
          .collection('userRecords')
          .where('role', isEqualTo: 'parent')
          .where('busAssigned', isEqualTo: driverBusNo)
          .where('isAbsent', isEqualTo: false)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot document) {
          GeoPoint pickupPoint = document['pickuppoint'];
          pickupPoints.add(pickupPoint);
        });
      });

// function to fetch emergency pickup points
      FirebaseFirestore.instance
          .collection('userRecords')
          .where('role', isEqualTo: 'parent')
          .where('busAssigned', isEqualTo: driverBusNo)
          .where('isAbsent', isEqualTo: true)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot document) {
          GeoPoint pickupPoint = document['pickuppoint'];
          emergencyPickupPoints.add(pickupPoint);
        });
      });


    }
    notifyListeners();
  }

//function to update driver profile
  Future<void> updateUserDetails(
      {String? email, String? contact, String? nida}) async {
    try {
      auth.User? user = auth.FirebaseAuth.instance.currentUser;

      if (user == null) {
        // User is not logged in
        print('User is not logged in');
        return;
      }

      final userId = user.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(userId);

      Map<String, dynamic> updatedData = {};

      if (email != null) {
        updatedData['email'] = email;
      }

      if (contact != null) {
        updatedData['contact'] = contact;
      }

      if (nida != null) {
        updatedData['nida'] = nida;
      }

      await userDocRef.update(updatedData);

      print('User details updated successfully!');
    } catch (error) {
      print('Error updating user details: $error');
      // Handle error or display error message to the user
    }
  }

  Future<void> updateParentDetails({String? email, String? contact}) async {
    try {
      auth.User? user = auth.FirebaseAuth.instance.currentUser;

      if (user == null) {
        // User is not logged in
        print('User is not logged in');
        return;
      }

      final userId = user.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('userRecords').doc(userId);

      Map<String, dynamic> updatedData = {};

      if (email != null) {
        updatedData['email'] = email;
      }

      if (contact != null) {
        updatedData['contact'] = contact;
      }

      await userDocRef.update(updatedData);

      print('User details updated successfully!');
    } catch (error) {
      print('Error updating user details: $error');
      // Handle error or display error message to the user
    }
  }

  Future<void> setPickuppoint() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is not logged in
      print('User is not logged in');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    GeoPoint location = GeoPoint(latitude, longitude);

    await FirebaseFirestore.instance
        .collection('userRecords')
        .doc(user.uid)
        .update({
      'pickuppoint': location,
    });
  }























}
