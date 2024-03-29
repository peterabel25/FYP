// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/user_management/update_driver.dart';
import 'package:school_bus_tracking_management_system_admin_module/user_management/update_student.dart';

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
      color: Colors.grey[200],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((_) => StudentRegistration())));
                        },
                        child: SizedBox(
                          height: 250,
                          width: 400,
                          child: Card(
                              child: Center(
                                  child: Column(children: [
                            Image.asset('momanddad.jpg',
                                height: 200, width: 200),
                            Text(
                              "STUDENT AND PARENT REGISTRATION",
                              style: TextStyle(fontSize: 18),
                            )
                          ]))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 47,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((_) => DriverRegistration())));
                        },
                        child: SizedBox(
                          height: 250,
                          width: 400,
                          child: Card(
                            child: Center(
                                child: Column(children: [
                              Image.asset('driver.jpeg',
                                  height: 200, width: 200),
                              // SizedBox(height:8),
                              Text(
                                "REGISTER DRIVER",
                                style: TextStyle(fontSize: 18),
                              ),
                            ])),
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
                      width: 40,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 250,
                        width: 400,
                        child: InkWell(
                          onTap:(){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: ((_) => UpdateStudentInfo())));
                          },
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height:18),
                                  Image.asset('edituser.png',
                                  height: 130, width: 150),
                                  SizedBox(height:10),
                                  Text(
                                    "UPDATE STUDENT'S INFO",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 47,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 250,
                        width: 400,
                        child: InkWell(
                          onTap:(){
 Navigator.of(context).push(MaterialPageRoute(
                              builder: ((_) => UpdateDriverInfo())));


                          },
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                   Image.asset('userupdate.jpg',
                                  height: 150, width: 200),
                                  Text(
                                    "UPDATE DRIVER'S INFO",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
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
