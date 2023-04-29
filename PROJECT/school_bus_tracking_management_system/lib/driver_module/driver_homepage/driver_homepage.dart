// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/driver_module/driver_screens/driver_notification.dart';
import '../../authentication/auth_service.dart';
import '../../authentication/login_page.dart';
import '../driver_screens/driver_emergency.dart';
import '../driver_screens/view_route.dart';

class DriverHomepage extends StatefulWidget {
  const DriverHomepage({Key? key}) : super(key: key);

  @override
  State<DriverHomepage> createState() => _DriverHomepageState();
}

class _DriverHomepageState extends State<DriverHomepage> {
  int _selectedTab = 0;
  List _pages = [ViewRoute(), DriverEmergency(), DriverNotification()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  AuthService authservice = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School bus Tracker"),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: 240,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/schoolbus.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(" Account Settings"),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    authservice.signOut();
                    Navigator.of(context)
                         .pushReplacement(MaterialPageRoute(builder: ((_) => LoginPage())));
                  },
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.telegram), label: "View Route"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert), label: "Emergency"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
        ],
      ),
    );
  }
}
