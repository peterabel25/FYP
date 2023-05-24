// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:geolocator/geolocator.dart';
//import 'package:permission_handler/permission_handler.dart';

class DriverData with ChangeNotifier {
  String? driverBusNo;
  String? email;
  String? firstName;
  String? lastName;
  List<GeoPoint> pickupPoints = [];

//function to fetch the user's document
  Future fetchDriverData() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(uid)
          .get();
      driverBusNo = snapshot['busPewa'];
      email = snapshot['email'];
      firstName = snapshot['firstName'];
      lastName = snapshot['lastName'];

      //function to fetch parents and their pickuppoint
      FirebaseFirestore.instance
          .collection('userRecords')
          .where('role', isEqualTo: 'parent')
          .where('busAssigned', isEqualTo: 'bus 2')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot document) {
          GeoPoint pickupPoint = document['pickuppoint'];
          pickupPoints.add(pickupPoint);
         // print(pickupPoints[0].longitude);
        });
      });

//Function to send location to db after every 30 seconds
      Timer.periodic(Duration(seconds: 20), (timer) async {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double latitude = position.latitude;
        double longitude = position.longitude;

        GeoPoint location = GeoPoint(latitude, longitude);

        await FirebaseFirestore.instance
            .collection('bus')
            .doc(driverBusNo)
            .update({
          'location': location,
        });
        print(location.latitude);
      });
    }
    notifyListeners();
  }
}



//deadcode
// final PermissionStatus status = await Permission.location.request();
    // if (status.isGranted) {
    //   Timer.periodic(Duration(seconds: 30), (timer) async {
        
    //     Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high,
    //     );

    //     double latitude = position.latitude;
    //     double longitude = position.longitude;

    //     GeoPoint location = GeoPoint(latitude, longitude);

    //     await FirebaseFirestore.instance
    //         .collection('bus')
    //         .doc(driverBusNo)
    //         .update({
    //       'location': location,
    //     });
    //     print(location.latitude);
    //   });
     
    // }