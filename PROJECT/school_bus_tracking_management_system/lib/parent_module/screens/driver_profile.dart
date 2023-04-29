// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    UserData userdataprovider = Provider.of<UserData>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Drivers Profile"),
      //   centerTitle: true,
      // ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 50, 12, 60),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("userRecords")
                .where('busPewa', isEqualTo: userdataprovider.busNo)
                .where('role', isEqualTo: 'driver')
                .snapshots()
                .map((snapshot) => snapshot.docs.first),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;

              // generate a widget to store the data
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 75,
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Row(
                        children: [
                          Text(
                            "Driver's Name:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            //'PETER',
                            data['firstName'] +
                                data['lastName'],
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Contacts:",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.phone),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                              //'56784903',
                              data['contact'],
                              style: TextStyle(fontSize: 17))
                        ],
                      ),
                    ],
                  ),
                ),
              );
              
            },
          )
          
          ),
    );
  }
}
