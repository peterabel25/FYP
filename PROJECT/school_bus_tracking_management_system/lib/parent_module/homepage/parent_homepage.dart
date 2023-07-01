// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/bus_info.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/notification_parent.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/parent_profile.dart';
import '../../authentication/auth_service.dart';
import '../../authentication/login_page.dart';
import '../providers/parent_data_provider.dart';
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
    NotificationsPage()
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userdataprovider = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("School bus Tracker"),
        centerTitle: true,
        
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        width: 240,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [

               UserAccountsDrawerHeader(currentAccountPicture:CircleAvatar(radius: 45, backgroundImage:AssetImage("assets/childandparent.jpg") ,) ,
                // ignore: prefer_adjacent_string_concatenation
                accountName: Text("${userdataprovider.firstName}" + " " + "${userdataprovider.lastName}"), 
                accountEmail: Text("${userdataprovider.email }")),
             
              SizedBox(
                height: 40,
              ),
             
              InkWell(
                onTap:(){
                   Navigator.of(context)
                         .push(MaterialPageRoute(builder: ((_) => ParentProfile())));
                } ,
                child: Text("Profile Settings")),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                                        _showAlertDialog();

                   // authservice.signOut();
                    //  Navigator.of(context)
                    //      .pushReplacement(MaterialPageRoute(builder: ((_) => LoginPage())));
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
        unselectedItemColor: const Color.fromARGB(255, 127, 126, 126),
        //unselectedLabelStyle:TextStyle(color:Colors.black ) ,
        selectedItemColor:Colors.deepPurple ,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.telegram), label: "Track bus"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Bus Info"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert), label: "Emergency"),
              BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
        ],
      ),
     
    );
  }

   Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                authservice.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((_) => LoginPage())));
              },
            ),
          ],
        );
      },
    );
  }
}
