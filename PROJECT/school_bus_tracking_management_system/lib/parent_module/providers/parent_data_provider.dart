import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserData with ChangeNotifier {
  String? busNo;
  String? firstName;
  String? lastName;
  String? email;

//function to fetch the user's document
  Future fetchUserData() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userRecords')
          .doc(uid)
          .get();
      firstName = snapshot['firstName'];
      lastName = snapshot['lastName'];
      busNo = snapshot['busAssigned'];
      email=snapshot['email'];
      notifyListeners();
    }
  }
}
