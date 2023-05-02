// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/bus_info.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/notification_parent.dart';
import '../../authentication/auth_service.dart';
import '../../authentication/login_page.dart';
import '../providers/user_data_provider.dart';
//import '../screens/driver_profile.dart';
import '../screens/parent_emergency.dart';
import '../screens/track_bus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    UserData userdataprovider = Provider.of<UserData>(context, listen: false);
    userdataprovider.fetchUserData();
    super.initState();
  }

  AuthService authservice = AuthService();

  int _selectedTab = 0;
  List _pages = [
    TrackBus(),
    BusInfo(),
    EmergencyPage(),
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
        actions: [
          IconButton(onPressed: () {

             Navigator.of(context)
                         .push(MaterialPageRoute(builder: ((_) => NotificationsPage())));

          }, icon: Icon(Icons.notifications_active))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        width: 240,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/childandparent.jpg"),
              ),
              SizedBox(
                height: 40,
              ),
             
              Text("Settings"),
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
              icon: Icon(Icons.telegram), label: "Track bus"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Bus Info"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert), label: "Emergency"),
        ],
      ),
     
    );
  }
}
