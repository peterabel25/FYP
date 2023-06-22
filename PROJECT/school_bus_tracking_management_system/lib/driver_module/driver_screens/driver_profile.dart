// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/auth_service.dart';
import '../driver_data_provider.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final nidaValidator = RegExp(r'^\d{20}$');
  AuthService authservice = AuthService();
  TextEditingController nidaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final emailValidator = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

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
                  height: 20,
                ),
                TextFormField(
                  controller: nidaController,
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
                  controller: emailController,
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
                  controller: contactController,
                  validator: (value) {
                    //if (value == "") return "Email is required";

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
                    if (Form.of(context)!.validate()) {
                      // Valid form, proceed with updating the values
                      String updatedNIDA = nidaController.text;
                      String updatedEmail = emailController.text;
                      String updatedContact = contactController.text;

                      // Perform the necessary operations with the updated values
                      driverdataprovider.updateUserDetails(
                        email:updatedEmail,
                        contact:updatedContact,
                        nida:updatedNIDA    
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

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: _formKey,
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
                if (_formKey.currentState?.validate() == true) {
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
