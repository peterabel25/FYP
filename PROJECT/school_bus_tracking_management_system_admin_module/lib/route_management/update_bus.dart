// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateBusInfo extends StatefulWidget {
  const UpdateBusInfo({super.key});

  @override
  State<UpdateBusInfo> createState() => _UpdateBusInfoState();
}

class _UpdateBusInfoState extends State<UpdateBusInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registered Buses'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bus').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final busDocs = snapshot.data!.docs;

          return DataTable(
            columns: [
              DataColumn(label: Text('Bus Number')),
              DataColumn(label: Text('Plate Number')),
              DataColumn(label: Text('Route Assigned')),
              DataColumn(label: Text('')),
            ],
            rows: busDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return DataRow(cells: [
                DataCell(Text(document.id)),
                DataCell(Text(data['plateNo'])),
                DataCell(Text(data['routeAssigned'])),
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
