// ignore_for_file: unused_element, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final String uid;
  UserDatabaseService({required this.uid});

  final CollectionReference userRecords =
      FirebaseFirestore.instance.collection('userRecords');

  Future createParentRecord(
      {required String firstName,
      required String lastName,
      required String contact,
      required String email,
      required String password,
      required String studentFname,
     // required String studentLname,
      required String studentClass,
      required String residence,
     // required String pickuppoint,
      required String busAssigned}) async {
    return await userRecords.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'contact': contact,
      'email': email,
     'password': password,
      'residence': residence,
     // 'pickuppoint': pickuppoint,
      'busAssigned': busAssigned,
      'role': 'parent'
    }).then((value) async{
return await userRecords.doc(uid).collection('students').add({
      'studentFname': studentFname,
     // 'studentLname': studentLname,
      'studentClass':studentClass
    });

    } );

    
  }

  Future createDriverRecord(
      {required String firstName,
      required String lastName,
      required String licenseNo,
      required String contact,
      required String email,
      required String password,
      required String busAssigned}) async {
    return await userRecords.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'licenseNo': licenseNo,
      'contact': contact,
      'email': email,
      'password': password,
      'busAssigned': busAssigned,
      'role': 'driver'
    });
  }
}
