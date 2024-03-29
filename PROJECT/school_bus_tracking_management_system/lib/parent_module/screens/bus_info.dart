// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/parent_data_provider.dart';

class BusInfo extends StatefulWidget {
  const BusInfo({Key? key}) : super(key: key);

  @override
  State<BusInfo> createState() => _BusInfoState();
}

class _BusInfoState extends State<BusInfo> {
  @override
  Widget build(BuildContext context) {
    UserData userdataprovider = Provider.of<UserData>(context);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 30),
            child: Card(
              child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('bus')
                      .doc(userdataprovider.busNo)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Text('Document does not exist');
                    }
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    GeoPoint location = data['location'];
                    double latitude = location.latitude;
                    double longitude = location.longitude;

                    // Use the data to build your widget
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/bus.jpeg"),
                            radius: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Bus Number:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${userdataprovider.busNo}",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Plate No:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(data['plateNo'],
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("userRecords")
                                .where('busAssigned',
                                    isEqualTo: userdataprovider.busNo)
                                .where('role', isEqualTo: 'driver')
                                .snapshots()
                                .map((snapshot) => snapshot.docs.first),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              // generate a widget to store the data
                              return Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Driver's Name:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        //'PETER',
                                        data['firstName'] +
                                            " " +
                                            data['lastName'],
                                        style: TextStyle(fontSize: 17),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 18),
                                  Row(
                                    children: [
                                      
                                      Text("Contacts:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 10,
                                      ),

                                      Text(
                                          //'56784903',
                                          data['contact'],
                                          style: TextStyle(fontSize: 17))
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }),
            )));
  }
}
