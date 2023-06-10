// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/authentication/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the main content of your app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
             
             
              Image.asset(
                "assets/bus.jpeg",
                //height: 150,
              ),
              
               Text(
                "Bus Tracker",
                style: TextStyle(
                  fontSize:25 ,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(height:5),
              CircularProgressIndicator( ),
            ],
          ),
        )),
      ),
    );
  }
}
