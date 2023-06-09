// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/route_management_database_service.dart';

class RouteRegister extends StatefulWidget {
  const RouteRegister({Key? key}) : super(key: key);

  @override
  State<RouteRegister> createState() => _RouteRegisterState();
}

class _RouteRegisterState extends State<RouteRegister> {
  final formkey = GlobalKey<FormState>();
  TextEditingController routenameController = TextEditingController();
  TextEditingController startpointController = TextEditingController();
  TextEditingController endpointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Registration"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return "Route Name is required";
                      }
                      return null;
                    },
                    controller: routenameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                        hintText: " label as Route A.."),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return "start point is required";
                      }
                      return null;
                    },
                    controller: startpointController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                      hintText: "Start point"),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return "End Point is required";
                      }
                      return null;
                    },
                    controller: endpointController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                      hintText: "End point"),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 36, 
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () { 
                            if (formkey.currentState!.validate()) {
                              databaseService.RegisterRoute(
                                routenameController.text,
                                startpointController.text,
                                endpointController.text
                                );

                                 ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Route Registered')));
                                routenameController.clear();
                                startpointController.clear();
                                endpointController.clear();
                            }

                          },
                          child: Text("Register")))
                ],
              )),
        ),
      ),
    );
  }
}
