// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup your profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
                child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  radius: 55,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "National Identity Number (NIDA)",
                      prefixIcon: Icon(Icons.perm_identity),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "confirm password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final snackBar = SnackBar(
                        content: Text('profile updated'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      minimumSize: Size(160, 43),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                    )),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
