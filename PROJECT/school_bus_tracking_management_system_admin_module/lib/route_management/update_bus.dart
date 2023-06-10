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
      appBar:AppBar(
        title:Text('Registered Buses') ,
        centerTitle:true
      ) ,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bus').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return ListTile(
               title: Row(
                 children: [
                   Text('Bus Number :'),
                    SizedBox(width:10 ,),

                   Text(document.id),

                 ],
               ),
                subtitle: Row(
                  children: [
                    Text("Plate Number:"),
                    SizedBox(width:10 ,),
                    Text(data['plateNo']),
                  ],
                ),
               // trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // do something when tile is tapped
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}