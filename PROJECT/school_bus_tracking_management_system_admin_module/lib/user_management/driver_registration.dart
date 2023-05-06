// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../authentication/user_auth_and_registration_service.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({Key? key}) : super(key: key);

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
 // TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController licensenoController = TextEditingController();
  TextEditingController bussAssignedController = TextEditingController();
  AuthService authservice = AuthService();

  String role = "driver";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Registration"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: fnameController,
                        decoration: InputDecoration(
                            label: Text("First name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "First name")),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: lnameController,
                        decoration: InputDecoration(
                            label: Text("Last name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Last name")),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  controller: emailController,
                  decoration: InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: "Email")),
             
              
            
              
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                    await authservice.createDriverWithEmailAndPassword(
                      busAssigned: bussAssignedController.text,
                      contact: contactController.text,
                      email: emailController.text,
                      firstName: fnameController.text,
                      lastName: lnameController.text,
                      licenseNo: licensenoController.text,
                      password: contactController.text,
                    );

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
    );
  }
}
