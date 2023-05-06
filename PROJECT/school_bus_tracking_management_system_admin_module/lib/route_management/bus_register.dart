// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/route_management_database_service.dart';

class BusRegister extends StatefulWidget {
  const BusRegister({Key? key}) : super(key: key);

  @override
  State<BusRegister> createState() => _BusRegisterState();
}

class _BusRegisterState extends State<BusRegister> {
  final formkey = GlobalKey<FormState>();
  TextEditingController busnumberController = TextEditingController();
  TextEditingController platenumberController = TextEditingController();
  TextEditingController routeassignedController = TextEditingController();
 TextEditingController driverassignedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return Scaffold(
      appBar: AppBar(title: Text("Register and Assign Bus"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: busnumberController,
                decoration: InputDecoration(hintText: "Bus No"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: platenumberController,
                decoration: InputDecoration(hintText: "Plate No"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: routeassignedController,
                decoration: InputDecoration(hintText: "Route Assigned"),
              ),
              SizedBox(height: 20),
              // TextFormField(
              //   controller: driverassignedController,
              //   decoration: InputDecoration(hintText: "Driver Assigned"),
              // ),
             // SizedBox(height: 20),
              SizedBox(
                  height: 36,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        databaseService.RegisterBus(
                            busnumberController.text,
                            platenumberController.text,
                            routeassignedController.text,
                            driverassignedController.text
                            );
                      },
                      child: Text("Register")))
            ],
          )),
        ),
      ),
    );
  }
}
