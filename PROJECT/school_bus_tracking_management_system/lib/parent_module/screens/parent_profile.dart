// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/auth_service.dart';
import '../../driver_module/driver_data_provider.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  AuthService authservice = AuthService();

  final phoneNumberValidator =
      RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');

  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DriverData driverdataprovider = Provider.of<DriverData>(context);

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
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (!emailValidator.hasMatch(value!)) {
                      return "Email not valid";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: contactController,
                  validator: (value) {
                    if (!phoneNumberValidator.hasMatch(value!)) {
                      return "Email not valid";
                    }
                    return null;
                  },
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
                    if (Form.of(context)!.validate()) {
                      // Valid form, proceed with updating the values
                      String updatedEmail = emailController.text;
                      String updatedContact = contactController.text;

                      // Perform the necessary operations with the updated values
                      driverdataprovider.updateParentDetails(
                        email: updatedEmail,
                        contact: updatedContact,
                      );

                      final snackBar = SnackBar(
                        content: Text('Profile updated'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    minimumSize: Size(160, 43),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    driverdataprovider.setPickuppoint();
                    //showPasswordInputDialog(context);
                  },
                  child: Text("Set Pickup Point !",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    showPasswordInputDialog(context);
                  },
                  child: Text("Change Password ?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  void showPasswordInputDialog(BuildContext context) {
    String newPassword = '';

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: formKey,
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                newPassword = value;
              },
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                return null;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate() == true) {
                  await authservice.changePassword(newPassword);
                  Navigator.of(context).pop();

                  print(newPassword);
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
