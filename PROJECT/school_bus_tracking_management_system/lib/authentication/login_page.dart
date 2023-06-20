// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_bus_tracking_management_system/authentication/auth_service.dart';
import 'package:school_bus_tracking_management_system/authentication/password_reset.dart';

//import '../homepage/homepage.dart';
//import '../parent_module/homepage/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authservice = AuthService();

  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset("assets/childandparent.jpg",height:150, ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
              child: Form(
                  child: Column(
                children: [
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
                          borderRadius: BorderRadius.circular(32.0),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Email is required";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {},
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                       prefixIcon: Icon(Icons.lock),
                        // suffixIcon: Icon(Icons.remove_red_eye_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await authservice.signInWithEmailAndPassword(context,
                            emailController.text, passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(160, 43),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap:(){
       Navigator.of(context).push(
                        MaterialPageRoute(builder: ((_) => PasswordReset())));

                    },

                    child: Text("Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
