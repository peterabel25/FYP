// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final nidaValidator = RegExp(r'^\d{20}$');
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup your profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                   // if (value == "") return "NIN is required";

                    if (!nidaValidator.hasMatch(value!)) {
                      return "NIN not valid";
                    }
                    return null;
                  },
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
                    validator: (value) {
                     // if (value == "") return "Email is required";

                       if (!emailValidator.hasMatch(value!)) {
                         return "Email not valid";
                       }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    //controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        )),
                  ),
                // TextFormField(
                //   obscureText: true,
                //   decoration: InputDecoration(
                //       hintText: "",
                //       prefixIcon: Icon(Icons.lock),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(14.0),
                //       )),
                // ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    validator: (value) {
                      if (value == "") return "Email is required";

                    //   if (!emailValidator.hasMatch(value!)) {
                    //     return "Email not valid";
                    //   }
                    //   return null;
                     },
                    //textInputAction: TextInputAction.next,
                    //controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Contact",
                        prefixIcon: Icon(Icons.phone),
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
                      "Save",
                      style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                    )),
SizedBox(
                  height: 25,
                ),

                Text("Change Password ?", style:TextStyle(fontWeight:FontWeight.bold))

              ],
            )),
          ),
        ),
      ),
    );
  }
}
