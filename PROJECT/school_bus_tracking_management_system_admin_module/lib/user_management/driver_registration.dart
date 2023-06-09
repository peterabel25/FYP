// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, dead_code, unnecessary_cast, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../authentication/user_auth_and_registration_service.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({Key? key}) : super(key: key);

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final formkey = GlobalKey<FormState>();

  // TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController licensenoController = TextEditingController();
  TextEditingController bussAssignedController = TextEditingController();
  AuthService authservice = AuthService();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  // final phonenumberValidator =
  //     RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$");

  final licenseValidator = RegExp(r"^[A-Z](?:\d[- ]*){14}$");
  //final nameValidator = RegExp(r"/^[A-Z]+$/i");
  final phoneNumberValidator =
      RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');

  final nameValidator = RegExp(r"^[A-Za-z]+$");

  String role = "driver";
  List<String> availableBuses = [];
  String selectedBus = '';
  String? busAssignmentError;

  Future<String?> validateBusAssignmentAvailability(String? busAssigned) async {
    if (busAssigned == null || busAssigned.isEmpty) {
      return "Bus assignment is required";
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('userRecords')
        .where('busPewa', isEqualTo: busAssigned)
        .where('role', isEqualTo: 'driver')
        .get();

    if (snapshot.docs.isNotEmpty) {
      return "Selected bus is already assigned to a driver";
    }

    return null;
  }

 

  @override
  void initState() {
    super.initState();
    fetchAvailableBuses();
  }

  Future<void> fetchAvailableBuses() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('bus').get();
    availableBuses = snapshot.docs.map((doc) => doc.id).toList();

    setState(() {
      availableBuses = availableBuses;
      selectedBus = availableBuses.first; // Select the first bus by default
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Registration"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              validator: (value) {
                                if (value == '')
                                  return "First name is required";
                                if (!nameValidator.hasMatch(value!)) {
                                  return "name not valid";
                                }
                                return null;
                              },
                              controller: fnameController,
                              decoration: InputDecoration(
                                  label: Text("First name"),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  hintText: "First name")),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                              validator: (value) {
                                if (value == '') return "Last name is required";
                                if (!nameValidator.hasMatch(value!)) {
                                  return "name not valid";
                                }
                                return null;
                              },
                              controller: lnameController,
                              decoration: InputDecoration(
                                  label: Text("Last name"),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  hintText: "Last name")),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == '') return "License Number is required";
                          // if (!licenseValidator.hasMatch(value!)) {
                          // return "license number not valid";
                          // }

                          return null;
                        },
                        controller: licensenoController,
                        decoration: InputDecoration(
                            label: Text("License No"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "License No")),

                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                        validator: (value) {
                          if (value == '') return "Contact is required";
                          if (!phoneNumberValidator.hasMatch(value!)) {
                            return "phonenumber not valid";
                          }
                          return null;
                        },
                        controller: contactController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            label: Text("Contact"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Contact")),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == '') return "Email is required";
                          if (!emailValidator.hasMatch(value!)) {
                            return "Email not valid";
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            label: Text("Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Email")),
                    SizedBox(
                      height: 20,
                    ),

                    //DROPDOWN TO SHOW REGISTERED BUSES
                    DropdownButtonFormField<String>(
                      // validator:submitForm(),
                      value: selectedBus,
                      onChanged: (value) {
                        setState(() {
                          selectedBus = value!;
                        });
                      },
                      items: availableBuses.map((bus) {
                        return DropdownMenuItem<String>(
                          value: bus,
                          child: Text(bus),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: "Bus Assigned",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Select a bus",
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              String? validationError =
                                  await validateBusAssignmentAvailability(
                                      selectedBus);
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
                                await authservice
                                    .createDriverWithEmailAndPassword(
                                  busAssigned: selectedBus,
                                  contact: contactController.text,
                                  email: emailController.text,
                                  firstName: fnameController.text,
                                  lastName: lnameController.text,
                                  licenseNo: licensenoController.text,
                                  password: contactController.text,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Driver Registered')));
                                contactController.clear();
                                licensenoController.clear();
                                bussAssignedController.clear();
                                emailController.clear();
                                fnameController.clear();
                                lnameController.clear();
                              }
                            }
                          },
                          child: Text("Register")),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
