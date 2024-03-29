// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

final CollectionReference<Map<String, dynamic>> _userRecordsCollection =
      FirebaseFirestore.instance.collection('userRecords');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _userRecordsCollection
            .where('role', isEqualTo: 'driver')
           // .where('busPewa')
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
                stream: messagesCollection.orderBy('timestamp', descending: true).snapshots(),
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
                     DateTime date = message['timestamp'].toDate();
                   String formattedDate = DateFormat('dd/MM hh:mm a').format(date);
                     
                      
                      return ListTile(
                        title: Text(message['Title']),
                        subtitle:Text(message['messageBody']),
                        trailing:Text(formattedDate) ,
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
