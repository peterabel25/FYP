// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../authentication/auth_service.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppBar(
      //   title:Text('Emergency') ,
      //   centerTitle:true ,
      // ) ,
      body: Container(
        child: Center(
          child: ElevatedButton(
              child: Text("Emergency"),
              onPressed: () {
                authservice.SendEmergency();
              }),
        ),
      ),
    );
  }
}
