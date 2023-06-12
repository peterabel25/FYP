// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
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

  final alphabetRegex = RegExp(r'[a-zA-Z]');
  final numberRegex = RegExp(r'\d');
  final plateNumberValidator = RegExp(r'^[A-Z]{1,2}\d{1,4}\s[A-Z]{1,3}$');

  List<String> availableRoutes = [];
  String selectedRoute = '';
  String? routeAssignmentError;

  Future<String?> validateRouteAssignmentAvailability(
      String? routeAssigned) async {
    if (routeAssigned == null || routeAssigned.isEmpty) {
      return "Route assignment is required";
    }

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('bus').
        where('routeAssigned', isEqualTo: routeAssigned)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return "Selected Route is already assigned to a bus";
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    fetchAvailableRoutes();
  }

  Future<void> fetchAvailableRoutes() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('route').get();
    availableRoutes = snapshot.docs.map((doc) => doc.id).toList();

    setState(() {
      availableRoutes = availableRoutes;
      selectedRoute = availableRoutes.first; // Select the first bus by default
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
           backgroundColor:Colors.grey[300],
          centerTitle: true, title: Text("REGISTER BUS ",style:TextStyle(
            color:Colors.black,fontWeight:FontWeight.bold,fontSize:20
          ))),
      // appBar: AppBar(title: Text("Register and Assign Bus"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          //   initialValue: "Bus ...",
                          validator: (value) {
                             if (value == '') return "Bus number is required";
                          if (!alphabetRegex.hasMatch(value!)&&!numberRegex.hasMatch(value!)) {
                            return " Bus number not valid";
                          }
                          return null;
                          },
                          controller: busnumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintText: "Bus Number"),
                        ),
                      ),
                                        SizedBox(width: 15),

                      Expanded(
                        child: TextFormField(
                                          validator: (value) {
                         if (value == '') return "Plate Number is required";
                                          if (!plateNumberValidator.hasMatch(value!)) {
                        return " Plate number not valid";
                                          }
                                          return null;
                                          },
                                          controller: platenumberController,
                                          decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: "Plate No"),
                                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),

                  //DROPDOWN LIST TO CHOOSE A ROUTE
                  DropdownButtonFormField<String>(
                    value: selectedRoute,
                    onChanged: (value) {
                      setState(() {
                        selectedRoute = value!;
                      });
                    },
                    items: availableRoutes.map((route) {
                      return DropdownMenuItem<String>(
                        value: route,
                        child: Text(route),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: "Route Assigned",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Select a Route",
                    ),
                  ),

                  SizedBox(height: 20),
                  SizedBox(
                      height: 36,
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              String? validationError =
                                  await validateRouteAssignmentAvailability(
                                      selectedRoute);
                              if (validationError != null) {
                                // Handle the bus assignment validation error
                                showDialog(
                                  // Display an error dialog with the validation message
                                  context: context,
                                    builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Validation Error"),
                                      content: Text(validationError),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the dialog
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // No bus assignment validation error, proceed with creating the driver
                                await databaseService.RegisterBus(
                                  busnumberController.text,
                                  platenumberController.text,
                                  selectedRoute,
                                  
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Bus Registered')));
                                busnumberController.clear();
                                platenumberController.clear();
                                //routeassignedController.clear();
                                driverassignedController.clear();
                              }
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
