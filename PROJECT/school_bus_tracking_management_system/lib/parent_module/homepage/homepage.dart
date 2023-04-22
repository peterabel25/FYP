// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/bus_info.dart';
import 'package:school_bus_tracking_management_system/parent_module/screens/user_profile.dart';

import '../../authentication/auth_service.dart';
import '../providers/user_data_provider.dart';
import '../screens/driver_profile.dart';
import '../screens/track_bus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState()  {
    UserData userdataprovider = Provider.of<UserData>(context, listen: false);
    userdataprovider.fetchUserData();
    super.initState();
  }

  AuthService authservice = AuthService();

  @override
  Widget build(BuildContext context) {
    UserData userdataprovider = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("School bus Tracker"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active))
        ],
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
                backgroundImage: AssetImage("assets/childandparent.png"),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Track Bus"),
              SizedBox(
                height: 20,
              ),
              Text("Declare Emergency"),
              SizedBox(
                height: 20,
              ),
              Text("Notifications"),
              SizedBox(
                height: 20,
              ),
              Text("Settings"),
              SizedBox(
                height: 20,
              ),
              Text("Logout"),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    //authservice.checkUser();
                   // userdataprovider.fetchUserData();
                    //ProductProvider productProvider = Provider.of(context);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((_) => BusInfo())));
                  },
                  child: SizedBox(
                    height: 180,
                    width: 150,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Image.asset("assets/bus.jpeg", width: 120),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Bus Info")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((_) => TrackBus())));
                  },
                  child: SizedBox(
                    height: 180,
                    width: 160,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Image.asset("assets/bustracker.jpeg", width: 120),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Track Bus")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                InkWell(
                  child: SizedBox(
                    height: 180,
                    width: 150,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Image.asset("assets/emergencyalert.jpeg",
                                width: 120),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Emergency")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: ((_) => DriverProfile())));
                  },
                  child: SizedBox(
                    height: 180,
                    width: 160,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Image.asset("assets/driver.jpeg", width: 120),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Driver Info")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox(
                  height: 180,
                  width: 160,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Image.asset("assets/settings.png",
                              width: 120, height: 122),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Settings")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
