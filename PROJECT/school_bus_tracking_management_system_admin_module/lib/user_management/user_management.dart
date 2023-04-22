// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'driver_registration.dart';
import 'studentandparent_registration.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            primary: false,
            //scrollDirection: Axis.vertical,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "USER MANAGEMENT",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => StudentRegistration())));
                        },
                        child: SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Text("STUDENT AND PARENT REGISTRATION"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => DriverRegistration())));
                        },
                        child: SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Text("REGISTER DRIVER"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        width: 400,
                        child: Card(
                          child: Center(
                            child: Text("UPDATE STUDENT'S INFO"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        width: 400,
                        child: Card(
                          child: Center(
                            child: Text("UPDATE DRIVER'S INFO"),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
