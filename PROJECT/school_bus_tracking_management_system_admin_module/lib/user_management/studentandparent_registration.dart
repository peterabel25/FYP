// ignore_for_file: prefer_const_constructors, unused_field

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

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Parent Info"),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '') return "First name is required";
                  return null;
                },
                controller: fnameController,
                decoration: InputDecoration(hintText: "First name"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') return "Last name is required";
                  return null;
                },
                controller: lnameController,
                decoration: InputDecoration(hintText: "Last name"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') return "Contact is required";
                  return null;
                },
                controller: contactController,
                decoration: InputDecoration(hintText: "contact"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') return "Email is required";
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
            ],
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
                  return null;
                },
                controller: studentfnameController,
                decoration: InputDecoration(hintText: " student's name"),
              ),
              // TextFormField(
              //   controller: studentlnameController,
              //   decoration: InputDecoration(hintText: "student's last name"),
              // ),
              TextFormField(
                validator: (value) {
                  if (value == '') return "Student class is required";
                  return null;
                },
                controller: studentclassController,
                decoration: InputDecoration(hintText: "student's class"),
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
                  return null;
                },
                controller: residenceController,
                decoration: InputDecoration(hintText: "Residence"),
              ),
              // TextFormField(
              //   controller: pickuppointController,
              //   decoration: InputDecoration(hintText: "pickup point "),
              // ),

              TextFormField(
                validator: (value) {
                  if (value == '') return "Assign bus to student";
                  return null;
                },
                controller: busassignedController,
                decoration: InputDecoration(hintText: "Bus Assigned "),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"),
        centerTitle: true,
      ),
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
                  // studentLname: studentlnameController.text,
                  studentClass: studentclassController.text,
                  residence: residenceController.text,
                  // pickuppoint: pickuppointController.text,
                  busAssigned: busassignedController.text);

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
                currentStep =0;
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
          // onStepTapped: (step) => setState(() {
          //   currentStep = step;
          // }),
          steps: getSteps(),
        )),
      ),
    );
  }
}
