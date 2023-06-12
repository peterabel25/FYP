// ignore_for_file: prefer_const_constructors, unused_field, valid_regexps, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/user_auth_and_registration_service.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({Key? key}) : super(key: key);

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  int currentStep = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  //TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController licensenoController = TextEditingController();
  TextEditingController bussAssignedController = TextEditingController();
  TextEditingController studentfnameController = TextEditingController();
  TextEditingController studentlnameController = TextEditingController();
  TextEditingController studentclassController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController pickuppointController = TextEditingController();
  TextEditingController busassignedController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  final phoneNumberValidator =
      RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');

  final nameValidator = RegExp(r"^[A-Za-z]+$");

  final studentClassValidator = RegExp(r'^[A-Za-z1-7\s]+$');

  final residenceValidator = RegExp(r"^[A-Za-z ]+$");

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Parent Info"),
        content: Form(
          key: formKeys[0],
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == '') return "First name is required";
                          if (!nameValidator.hasMatch(value!)) {
                            return "name not valid";
                          }
                          return null;
                        },
                        controller: fnameController,
                        decoration: InputDecoration(
                            label: Text("First name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "First name"),
                      ),
                    ),
                    SizedBox(
                  width: 20,
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
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Last name"),
                    // decoration: InputDecoration(hintText: "Last name"),
                  ),
                ),
                  ],
                ),
                
                SizedBox(
                  height: 15,
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Contact"),
                  // decoration: InputDecoration(hintText: "contact"),
                ),
                SizedBox(
                  height: 15,
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Email"),
                  // decoration: InputDecoration(hintText: "Email"),
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text("student Info"),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '') return "Student name is required";
                  if (!nameValidator.hasMatch(value!)) {
                    return "name not valid";
                  }
                  return null;
                },
                controller: studentfnameController,
                decoration: InputDecoration(
                    label: Text("Student's Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Student's Name"),
                //decoration: InputDecoration(hintText: " student's name"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') return "Student class is required";
                  if (!studentClassValidator.hasMatch(value!)) {
                    return "enter valid student class";
                  }
                  return null;
                },
                controller: studentclassController,
                decoration: InputDecoration(
                    label: Text("Student's class"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Student's Class"),
                // decoration: InputDecoration(hintText: "student's class"),
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text("Bus Assignment"),
        content: Form(
          key: formKeys[2],
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '') return "Student's residence is required";
                  if (!residenceValidator.hasMatch(value!)) {
                    return "enter valid Residence";
                  }
                  return null;
                },
                controller: residenceController,
                decoration: InputDecoration(
                    label: Text("Residence"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Residence"),
                // decoration: InputDecoration(hintText: "Residence"),
              ),
              SizedBox(
                height: 15,
              ),

              DropdownButtonFormField<String>(
                value: selectedBus,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBus = newValue!;
                  });
                },
                items: busList.map((String busId) {
                  return DropdownMenuItem<String>(
                    value: busId,
                    child: Text(busId, style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Bus Assigned',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Select a bus',
                ),
              )
            ],
          ),
        ),
      ),
    ];
  }

  List<String> busList = []; // List to store bus IDs
  String selectedBus = ''; // Selected bus ID

  @override
  void initState() {
    super.initState();
    fetchBuses();
  }

  Future<void> fetchBuses() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bus').get();

      // Extract bus IDs from the documents
      List<String> buses = querySnapshot.docs.map((doc) => doc.id).toList();

      setState(() {
        busList = buses;
        selectedBus = buses.first; // Select the first bus by default
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor:Colors.grey[200],
          centerTitle: true, title: Text("USER REGISTRATION",style:TextStyle(
            color:Colors.black,fontWeight:FontWeight.bold,fontSize:20
          ))),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: () => currentStep == 0
                ? null
                : setState(() {
                    currentStep -= 1;
                  }),
            onStepContinue: () {
              bool isLastStep = (currentStep == getSteps().length - 1);
              if (isLastStep) {
                authService.createParentWithEmailAndPassword(
                  firstName: fnameController.text,
                  lastName: lnameController.text,
                  contact: contactController.text,
                  email: emailController.text,
                  password: contactController.text,
                  studentFname: studentfnameController.text,
                  studentClass: studentclassController.text,
                  residence: residenceController.text,
                  busAssigned:
                      selectedBus, // Use selectedBus instead of busassignedController.text
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('User Registered')));

                emailController.clear();
                fnameController.clear();
                lnameController.clear();
                contactController.clear();
                licensenoController.clear();
                bussAssignedController.clear();
                studentfnameController.clear();
                studentlnameController.clear();
                studentclassController.clear();
                residenceController.clear();
                pickuppointController.clear();
                busassignedController.clear();

                setState(() {
                  currentStep = 0;
                });

                //Do something with this information
              } else {
                if (formKeys[currentStep].currentState!.validate()) {
                  setState(() {
                    currentStep += 1;
                  });
                }
              }
            },
            steps: getSteps(),
          ),
        ),
      ),
    );
  }
}
