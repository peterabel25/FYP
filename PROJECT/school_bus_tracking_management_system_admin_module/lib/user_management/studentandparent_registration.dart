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
  TextEditingController passwordController = TextEditingController();
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
                controller: fnameController,
                decoration: InputDecoration(hintText: "First name"),
              ),
              TextFormField(
                controller: lnameController,
                decoration: InputDecoration(hintText: "Last name"),
              ),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(hintText: "contact"),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "password"),
              ),
              // TextFormField(
              //   initialValue:"parent" ,
              //   decoration:InputDecoration(
              //     hintText:"Role"
              //   ) ,
              // ),
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
                controller: studentfnameController,
                decoration: InputDecoration(hintText: " student's first name"),
              ),
              TextFormField(
                controller: studentlnameController,
                decoration: InputDecoration(hintText: "student's last name"),
              ),
              TextFormField(
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
        title: Text("Address Info"),
        content: Form(
          key: formKeys[2],
          child: Column(
            children: [
              TextFormField(
                controller: residenceController,
                decoration: InputDecoration(hintText: "Residence"),
              ),
              TextFormField(
                controller: pickuppointController,
                decoration: InputDecoration(hintText: "pickup point "),
              ),
              // TextFormField(
              //   decoration:InputDecoration(
              //     hintText:"Route Assigned "
              //   ) ,
              // ),
              TextFormField(
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
                  password: passwordController.text,
                  studentFname: studentfnameController.text,
                  studentLname: studentlnameController.text,
                  studentClass: studentclassController.text,
                  residence: residenceController.text,
                  pickuppoint: pickuppointController.text,
                  busAssigned: bussAssignedController.text);
              //Do something with this information
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          steps: getSteps(),
        )),
      ),
    );
  }
}
