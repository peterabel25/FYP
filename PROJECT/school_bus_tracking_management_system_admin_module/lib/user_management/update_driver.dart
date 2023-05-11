import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDriverInfo extends StatefulWidget {
  const UpdateDriverInfo({super.key});

  @override
  State<UpdateDriverInfo> createState() => _UpdateDriverInfoState();
}

class _UpdateDriverInfoState extends State<UpdateDriverInfo> {
// final CollectionReference<Map<String, dynamic>> _userRecordsCollection =
//       FirebaseFirestore.instance.collection('userRecords');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Registered Drivers') ,
        centerTitle:true
      ) ,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userRecords').where('role', isEqualTo: 'driver').snapshots(),
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
                   Text(data['firstName']),
                   Text(data['lastName']),

                 ],
               ),
                subtitle: Text(data['email']),
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