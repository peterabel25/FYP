// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/user_auth_and_registration_service.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/login.dart';


class AdminRegister extends StatefulWidget {
  const AdminRegister({Key? key}) : super(key: key);

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  final passwordValidator = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: SizedBox(
                height: 450,
                width: 350,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Form(
                    key: formkey,
                    child: Column(children: [
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.account_circle_sharp,
                            size: 80,
                          ),
                          radius: 40),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
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
                        height: 45,
                      ),
                      SizedBox(
                          height: 37,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () async {
                                if(formkey.currentState!.validate()){
                                  await authservice
                                    .createUserWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                        Navigator.pop(context);
                                }
                                
                                
                              },
                              child: Text("Register",
                                  style: TextStyle(
                                      fontSize: 17, letterSpacing: 1)))),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((_) => LoginPage())));
                          },
                          child: Text("Already have an Account? Login"))
                    ]),
                  ),
                )),
              ),
            ),
          ),
        ));
  }
}
