// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../driver_screens/student_list.dart';
import '../driver_screens/view_route.dart';

class DriverHomepage extends StatefulWidget {
  const DriverHomepage({Key? key}) : super(key: key);

  @override
  State<DriverHomepage> createState() => _DriverHomepageState();
}

class _DriverHomepageState extends State<DriverHomepage> {
int _selectedTab = 0;
List _pages = [
  ViewRoute(),
  Text("driver emergency"),
  Text("Notifications")
];


 _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("School bus Tracker"),
          centerTitle: true,
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active))
          // ],
        ),
        drawer: Drawer(
          width: 240,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
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
                Text("Logout"),
              ],
            ),
          ),
        ),
         body:_pages[_selectedTab],
          bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
       // selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.telegram), label: "View Route"),
          BottomNavigationBarItem(icon: Icon(Icons.emergency), label: "Emergency"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
         
        ],
      ),
        
        );
  }
}
