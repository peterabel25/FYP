// ignore_for_file: prefer_const_constructors, unused_element, dead_code

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../authentication/user_auth_and_registration_service.dart';

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
                  void showParentDetailsDialog(
                    BuildContext context,
                  ) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Parent Details"),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'First name :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(data['firstName']),
                              SizedBox(height: 8),
                              Text(
                                'Last name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(data['lastName']),
                              SizedBox(height: 8),
                              Text(
                                'contact',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(data['contact']),
                              SizedBox(height: 8),
                              Text(
                                'Residence',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(data['residence']),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  showParentDetailsDialog(context);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
