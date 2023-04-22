// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                "NOTIFICATIONS",
                style: TextStyle( 
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 23),
              Card(
                child: ListTile(
                  title: Text("Emergency alert ! "),
                  subtitle: Text("heavy traffic via Nyerere Road"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Emergency alert ! "),
                  subtitle: Text("heavy traffic via Nyerere Road"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
