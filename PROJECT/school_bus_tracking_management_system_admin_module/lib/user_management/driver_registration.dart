// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

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

  String role = "driver";
  String _selectedOption = 'A';
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
                          return null;
                        },
                        controller: contactController,
                        decoration: InputDecoration(
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
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Email")),
                    SizedBox(
                      height: 20,
                    ),

                    //Dropdown to show all registered buses
                    TextFormField(
                        validator: (value) {
                          if (value == '') return "Bus assignment is required";
                          return null;
                        },
                        controller: bussAssignedController,
                        decoration: InputDecoration(
                            label: Text("Bus Assigned "),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "bus assigned ")),

                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await authservice.createDriverWithEmailAndPassword(
                              busAssigned: bussAssignedController.text,
                              contact: contactController.text,
                              email: emailController.text,
                              firstName: fnameController.text,
                              lastName: lnameController.text,
                              licenseNo: licensenoController.text,
                              password: contactController.text,
                            );
                          }

                          contactController.clear();
                          licensenoController.clear();
                          bussAssignedController.clear();
                          emailController.clear();
                          fnameController.clear();
                          lnameController.clear();
                          // passwordController.clear();
                        },
                        child: Text("Register"))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
