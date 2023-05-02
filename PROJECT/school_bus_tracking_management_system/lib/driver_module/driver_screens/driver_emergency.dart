// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../authentication/auth_service.dart';

class DriverEmergency extends StatefulWidget {
  const DriverEmergency({super.key});

  @override
  State<DriverEmergency> createState() => _DriverEmergencyState();
}

class _DriverEmergencyState extends State<DriverEmergency> {
  @override
  Widget build(BuildContext context) {
    AuthService authservice = AuthService();

    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  authservice.driverEmergency();
                },
                child: Text("driver emergency"))));
  }
}
