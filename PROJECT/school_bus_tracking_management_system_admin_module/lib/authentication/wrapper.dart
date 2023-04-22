import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/usermodal.dart';

import '../homepage/homepage.dart';
import 'user_auth_and_registration_service.dart';
import 'login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            // ignore: prefer_const_constructors
            return user == null ? LoginPage() : Homepage();
          } else {
            // ignore: prefer_const_constructors

            return Scaffold(body:Center(child:CircularProgressIndicator()));
          }
        });
  }
}
