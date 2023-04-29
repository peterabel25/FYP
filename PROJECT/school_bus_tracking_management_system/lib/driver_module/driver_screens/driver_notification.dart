// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class DriverNotification extends StatefulWidget {
  const DriverNotification({super.key});

  @override
  State<DriverNotification> createState() => _DriverNotificationState();
}

class _DriverNotificationState extends State<DriverNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text("Notifications") ,
      ) ,
    );
  }
}