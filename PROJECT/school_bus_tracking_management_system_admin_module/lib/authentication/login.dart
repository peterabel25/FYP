// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/admin_register.dart';
//import 'package:school_bus_tracking_management_system_admin_module/homepage/homepage.dart';

import '../providers/admin_provider.dart';
import 'user_auth_and_registration_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final passwordValidator = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final adminprovider = Provider.of<AdminProvider>(context);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Center(
              child: SizedBox(
                height: 500,
                width: 350,
                child: Card(
                  elevation:0,
                    child: Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          Text("WELCOME BACK !",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset("childandparent.png", height: 100),
                          SizedBox(
                            height: 30,
                          ),
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
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == "") return "Password is required";
                              if (!passwordValidator.hasMatch(value!)) {
                                return "password not valid";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "password",
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 40,
                              width: 310,
                              child: OutlinedButton(
style: OutlinedButton.styleFrom(
    backgroundColor: Colors.deepPurple, 
  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await authservice.signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text);
                                      adminprovider.adminEmail =
                                          emailController.text;
                                    }
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                        color:Colors.white,
                                          fontSize: 17, letterSpacing: 1)))),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((_) => AdminRegister())));
                              },
                              child: Text("New User ? Register Account",style:TextStyle( ) ,))
                        ]),
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
