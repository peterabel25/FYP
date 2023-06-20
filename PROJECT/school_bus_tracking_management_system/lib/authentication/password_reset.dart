// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'auth_service.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final formkey = GlobalKey<FormState>();
  AuthService authservice = AuthService();
  TextEditingController emailController = TextEditingController();

  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 25, right: 25),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text("Forgot your Password ?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == "") return "Email is required";

                  if (!emailValidator.hasMatch(value!)) {
                    return "Email not valid";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      authservice.sendPasswordResetEmail(emailController.text);
                      _showAlertDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    minimumSize: Size(160, 43),
                  ),
                  child: Text(
                    "submit",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                  )),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Email sent successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Visit your email to get your new password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
