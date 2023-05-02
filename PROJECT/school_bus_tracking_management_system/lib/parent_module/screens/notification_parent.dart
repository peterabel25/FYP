// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../providers/parent_data_provider.dart';
class NotificationsPage extends StatelessWidget {
  // NotificationsPage({super.key});
  final CollectionReference<Map<String, dynamic>> _userRecordsCollection =
      FirebaseFirestore.instance.collection('userRecords');

  @override
  Widget build(BuildContext context) {
  UserData userdataprovider = Provider.of<UserData>(context);

    return Scaffold(
      appBar:AppBar(
        title:Text('Notifications') ,
        centerTitle:true ,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _userRecordsCollection
            .where('role', isEqualTo: 'driver')
            .where('busPewa', isEqualTo:userdataprovider.busNo )
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // get the list of documents from the snapshot
          final documents = snapshot.data!.docs;

          // use the documents to build your UI
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final document = documents[index];
              final messagesCollection =
                  document.reference.collection('messages');

              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: messagesCollection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  // get the list of documents from the snapshot
                  final messages = snapshot.data!.docs;

                  // use the messages to build your UI
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message['messageBody']),
                        subtitle: Text(message['sender']),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

