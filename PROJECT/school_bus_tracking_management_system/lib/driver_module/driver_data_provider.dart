import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class DriverData with ChangeNotifier {
   String? driverBusNo;
  
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
      // notifyListeners();
    }
  }

  
}
