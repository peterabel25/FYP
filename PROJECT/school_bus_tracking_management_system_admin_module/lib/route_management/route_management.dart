// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'bus_register.dart';
import 'route_register.dart';

class RouteManagementPage extends StatefulWidget {
  const RouteManagementPage({Key? key}) : super(key: key);

  @override
  State<RouteManagementPage> createState() => _RouteManagementPageState();
}

class _RouteManagementPageState extends State<RouteManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            primary:false,
            //scrollDirection: Axis.vertical,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text("ROUTE MANAGEMENT",
                style: TextStyle(
                  fontSize: 20,
                ),),
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
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => RouteRegister())));
                        },
                        child: SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Text("REGISTER ROUTE"),
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
                                builder: ((_) => BusRegister())));
                        },
                        child: SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Text("REGISTER AND ASSIGN BUS TO ROUTE "),
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
                            child: Text("UPDATE ROUTE"),
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
                            child: Text("UPDATE BUS INFO"),
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
