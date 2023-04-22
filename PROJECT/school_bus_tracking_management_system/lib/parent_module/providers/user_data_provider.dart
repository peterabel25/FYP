import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserData with ChangeNotifier {
  //DocumentSnapshot? busData;
  String? plateNo;
  String? busNo;
  String? contact;
  String? assignedDriver;
  String? driverFirstName;
  String? driverLastName;

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

//function to fetch info about the driver of the bus
  // Future fetchDriverData() async {
  //   CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection("userRecords");
  //   Query query = usersCollection.where('busPewa', isEqualTo: busNo).where('role', isEqualTo:'driver');
  //   query.get().then((QuerySnapshot snapshot) {
  //     if (snapshot.size > 0) {
  //       // Loop through the snapshot to access the driver documents
  //       snapshot.docs.forEach((doc) {
  //         // Get the driver information from the driver document
  //         // var driverId = doc.id;
  //         contact = doc['contact'];
  //         driverFirstName = doc['firstName'];
  //         driverLastName = doc['lastName'];

  //         print(snapshot.size);

  //         print(contact);
  //         print(driverFirstName);
  //         print(driverLastName);
  //         // print("Driver ID: $driverId");
  //         // print("Driver Contact: $driverContact");
  //       });
  //     } else {
  //       print("Driver with not found");
  //     }
  //   }).catchError((error) {
  //     print("Error getting driver documents: $error");
  //   });
    // notifyListeners();
  //}
  
}
