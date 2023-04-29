// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DriverEmergency extends StatefulWidget {
  const DriverEmergency({super.key});

  @override
  State<DriverEmergency> createState() => _DriverEmergencyState();
}

class _DriverEmergencyState extends State<DriverEmergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text("driver emergency")
      )
    );
  }
}