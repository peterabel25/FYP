// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateRouteInfo extends StatefulWidget {
  const UpdateRouteInfo({super.key});

  @override
  State<UpdateRouteInfo> createState() => _UpdateRouteInfoState();
}

class _UpdateRouteInfoState extends State<UpdateRouteInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Registered Routes'),
        centerTitle:true
      ) ,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('route').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
 final routeDocs = snapshot.data!.docs;

          return DataTable(
            columns: [
              DataColumn(label: Text('Route Name')),
              DataColumn(label: Text('Start Point')),
              DataColumn(label: Text('End Point')),
              DataColumn(label: Text('')),
            ],
            rows: routeDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return DataRow(cells: [
                DataCell(Text(document.id)),
                DataCell(Text(data['startPoint'])),
                DataCell(Text(data['endPoint'])),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 233, 38, 24),
                        ),
                        child: Text("Delete")),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 42, 148, 45),
                      ),
                      child: Text("Edit"),
                    ),
                  ],
                )),
              ]);



            }).toList(),
          );
        },
      ),
    );

  }
}