// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system/driver_module/driver_screens/driver_notification.dart';
import '../../authentication/auth_service.dart';
import '../../authentication/login_page.dart';
import '../driver_data_provider.dart';
import '../driver_screens/driver_emergency.dart';
import '../driver_screens/driver_profile.dart';
import '../driver_screens/view_route.dart';

class DriverHomepage extends StatefulWidget {
  const DriverHomepage({Key? key}) : super(key: key);

  @override
  State<DriverHomepage> createState() => _DriverHomepageState();
}

class _DriverHomepageState extends State<DriverHomepage> {
  @override
  void initState() {
    DriverData driverdataprovider =
        Provider.of<DriverData>(context, listen: false);
    driverdataprovider.fetchDriverData();
    super.initState();
  }

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
    DriverData driverdataprovider = Provider.of<DriverData>(context);
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
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/schoolbus.png"),
                  ),
                  accountName: Text("${driverdataprovider.firstName}" +
                      "${driverdataprovider.lastName}"),
                  accountEmail: Text("${driverdataprovider.email}")),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    //  getLocation();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: ((_) => DriverProfile())));
                  },
                  child: Text(" Profile Settings")),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    _showAlertDialog();
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

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Declare Emergency'),
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
