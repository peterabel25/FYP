// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../authentication/user_auth_and_registration_service.dart';
import 'user_details_screens/parents_details.dart';

class UpdateStudentInfo extends StatefulWidget {
  const UpdateStudentInfo({super.key});

  @override
  State<UpdateStudentInfo> createState() => _UpdateStudentInfoState();
}

class _UpdateStudentInfoState extends State<UpdateStudentInfo> {
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registered Parents'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('userRecords')
            .where('role', isEqualTo: 'parent')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return ListTile(
                title: Row(
                  children: [
                    Text(data['firstName']),
                    Text(data['lastName']),
                  ],
                ),
                subtitle: Text(data['email']),
                trailing: InkWell(
                    onTap: () {
                      authservice.deleteRegisteredUser(
                          data['email'], data['password']);

                      authservice.deleteUserData(document.id);
                    },
                    child: Icon(Icons.delete)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParentsDetails(data: data),
                    ),
                  );
                  // do something when tile is tapped
                },
              );
            }).toList(),
          );
        },
      ),
    );
    //const Placeholder();
  }
}
