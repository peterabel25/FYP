// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

import '../../authentication/auth_service.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  AuthService authservice = AuthService();
  String dropdownValue = 'Child wont Attend';
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
              items: <String>['Child wont Attend', 'Child will Delay']
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
            decoration: InputDecoration(
                filled: true, hintText: 'start with the name of your child'),
          ),
        ),

        SizedBox(
          height: 15,
        ),

//parent button to be disabled
        SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: (DateTime.now().hour >= 6 && DateTime.now().hour <=4  )
                ? null
                : () {
                    _showAlertDialog();
                  },
            child: Text("Declare emergency"),
            style: ElevatedButton.styleFrom(
              primary: (DateTime.now().hour >= 6 && DateTime.now().hour <=4  )
                  ? Colors.grey
                  : Colors.deepPurple,
            ),
          ),
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
                authservice.SendEmergency(
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
