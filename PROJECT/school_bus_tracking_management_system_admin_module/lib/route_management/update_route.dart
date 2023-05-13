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
        title:Text('Registered Routes') ,
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
return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return ListTile(
               title: Row(
                 children: [
                   Text('Start Point:'),
                    SizedBox(width:10 ,),

                   Text(data['startPoint']),

                 ],
               ),
                subtitle: Row(
                  children: [
                    Text("End Point:"),
                    SizedBox(width:10 ,),
                    Text(data['endPoint']),
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