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
                              //Text("REGISTER ROUTE"),
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
                        child: Card(
                          child: Center(
                            child: Text("UPDATE ROUTE"),
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
