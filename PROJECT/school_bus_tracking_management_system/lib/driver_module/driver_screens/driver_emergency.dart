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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Form(
          child: Column(children: [
        //dropdown list widget to contain the options

        Row(
          children: [
            Text("Emergency:", style: TextStyle(fontSize: 23)),
            SizedBox(width: 15),
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['Heavy Traffic', 'Car Breakdown', 'Delay']
                  .map<DropdownMenuItem<String>>((String value) {
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
          ],
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 300, // <-- TextField width
          height: 127, // <-- TextField height
          child: TextField(
            controller: descriptionController,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            decoration:
                InputDecoration(filled: true, hintText: 'Add more Description'),
          ),
        ),

        SizedBox(
          height: 15,
        ),

        SizedBox(
          height: 45,
          child: ElevatedButton(
              onPressed: () {
                _showAlertDialog();
              },
              child: Text("Declare emergency")),
        )
      ])),
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
              onPressed: () {
                authservice.driverEmergency(
                    dropdownValue, descriptionController.text);
                descriptionController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
