// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';

import '../../authentication/auth_service.dart';

class DriverEmergency extends StatefulWidget {
  const DriverEmergency({super.key});

  @override
  State<DriverEmergency> createState() => _DriverEmergencyState();
}

class _DriverEmergencyState extends State<DriverEmergency> {
  String dropdownValue = 'Heavy Traffic';
  AuthService authservice = AuthService();
  TextEditingController descriptionController = TextEditingController();
  final descriptionvalidator = RegExp(r'^[a-zA-Z ]+$');
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 0,
              child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(children: [
                      //dropdown list widget to contain the options

                      Text("State Emergency:", style: TextStyle(fontSize: 23)),
                      SizedBox(height: 19),
                      DropdownButton<String>(
                        // Step 3.
                        value: dropdownValue,
                        // Step 4.
                        items: <String>[
                          'Heavy Traffic',
                          'Car Breakdown',
                          'Delay'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300, // <-- TextField width
                        height: 150, // <-- TextField height
                        child: TextFormField(
                          validator: (value) {
                            if (value == "") return "description is required";

                            if (!descriptionvalidator.hasMatch(value!)) {
                              return "description not valid";
                            }
                            return null;
                          },
                          controller: descriptionController,
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              filled: true, hintText: 'Add more Description'),
                        ),
                      ),

                      SizedBox(
                        height: 45,
                      ),

                      SizedBox(
                        height: 37,
                        child: ElevatedButton(
                            onPressed: () {
                              _showAlertDialog();
                            },
                            child: Text("Declare emergency")),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                    ]),
                  )),
            ),
          ),
        ));
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Declare Emergency'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to declare the  emergency?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  authservice.driverEmergency(
                      dropdownValue, descriptionController.text);
                  descriptionController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
