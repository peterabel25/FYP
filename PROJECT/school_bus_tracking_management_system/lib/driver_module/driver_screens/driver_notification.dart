// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../parent_module/providers/parent_data_provider.dart';
import '../driver_data_provider.dart';
import 'package:intl/intl.dart';


class DriverNotification extends StatefulWidget {

  @override
  State<DriverNotification> createState() => _DriverNotificationState();
}

class _DriverNotificationState extends State<DriverNotification> {
  final CollectionReference<Map<String, dynamic>> _userRecordsCollection =
      FirebaseFirestore.instance.collection('userRecords');

  @override
  Widget build(BuildContext context) {
      DriverData driverdataprovider = Provider.of<DriverData>(context);

    return Scaffold(
      backgroundColor:Colors.grey[200] ,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _userRecordsCollection
            .where('role', isEqualTo: 'parent')
            .where('busAssigned', isEqualTo:driverdataprovider.driverBusNo )
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
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                        child: Card(
                          child: ListTile(
                            title: Text(message['Title']),
                            subtitle:Text(message['messageBody']),
                            trailing:Text(formattedDate) ,
                          ),
                        ),
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
