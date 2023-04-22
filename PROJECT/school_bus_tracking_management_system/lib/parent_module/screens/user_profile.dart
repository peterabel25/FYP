// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 50, 12, 60),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 75,
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  children: [
                    Text(
                      "Student's Name:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Peter Abel",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Class:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Text("3B", style: TextStyle(fontSize: 17))
                  ],
                ),
                Row(
                  children: [
                    Text("Gender:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Text("M", style: TextStyle(fontSize: 17))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
