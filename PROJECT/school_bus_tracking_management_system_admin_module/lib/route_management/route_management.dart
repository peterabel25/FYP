// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/update_bus.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/update_route.dart';

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
    return 
    Container(
      color: Colors.grey[200],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            primary:false,
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
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => RouteRegister())));
                        },
                        child: SizedBox(
                          height: 250,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Column(
                                children:[
                                  SizedBox(height:8 ,),
                                Image.asset('route.jpg' ,height:150,width:200),
                                 SizedBox(height:20),
                                Text("REGISTER ROUTE",style:TextStyle(fontSize:18 )),  
                                ]
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 47,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => BusRegister())));
                        },
                        child: SizedBox(
                          height: 250,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Column(
                                children:[
                                Image.asset('schoolbusicon.jpg' ,height:150,width:200),
                                 SizedBox(height:20),

                                Text("REGISTER AND ASSIGN BUS TO ROUTE ",style:TextStyle(fontSize:18 )),
                                ]
                              )
                              //Text("REGISTER AND ASSIGN BUS TO ROUTE "),
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
                      width: 40,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 250,
                        width: 400,
                        child: InkWell(
                          onTap:(){

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => UpdateRouteInfo())));
                          },
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height:18),
                                  Image.asset('routeupdate.png',
                                  height: 150, width: 200),
                                  SizedBox(height:10),
                                  Text("UPDATE ROUTE",
                                    style: TextStyle(fontSize: 18),),
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
                                builder: ((_) => UpdateBusInfo())));
                          },
                          child: Card(
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset('info.jpg',
                                  height: 200, width: 200),
                                  Text("UPDATE BUS INFO",
                                    style: TextStyle(fontSize: 18),),
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
