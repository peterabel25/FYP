import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserData with ChangeNotifier {
  //DocumentSnapshot? busData;
  // String? plateNo;
   String? busNo;
  // String? contact;
  // String? assignedDriver;
  // String? driverFirstName;
  // String? driverLastName;

//function to fetch the user's document
  Future fetchUserData() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(uid)
          .get();
      busNo = snapshot['busAssigned'];
      // notifyListeners();
    }
  }

  
}
