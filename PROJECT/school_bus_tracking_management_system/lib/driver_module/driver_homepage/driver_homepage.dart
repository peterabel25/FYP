// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DriverHomepage extends StatefulWidget {
  const DriverHomepage({Key? key}) : super(key: key);

  @override
  State<DriverHomepage> createState() => _DriverHomepageState();
}

class _DriverHomepageState extends State<DriverHomepage> {
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage("assets/schoolbus.png"),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("View Bus Route"),
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
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: ((_) => UserProfile())));
                      },
                      child: SizedBox(
                        height: 180,
                        width: 150,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // Image.asset("assets/userprofile.png", width: 120),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("View Route")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 180,
                      width: 160,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: ((_) => BusInfo())));
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
                                Text("Student List")
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
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: ((_) => DriverProfile())));
                      },
                      child: SizedBox(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
