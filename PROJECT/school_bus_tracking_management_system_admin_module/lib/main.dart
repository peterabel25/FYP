// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:school_bus_tracking_management_system_admin_module/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_bus_tracking_management_system_admin_module/user_management/driver_registration.dart';
//import 'package:school_bus_tracking_management_system_admin_module/homepage/homepage.dart';
import 'authentication/user_auth_and_registration_service.dart';
import 'authentication/wrapper.dart';
import 'firebase_options.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';

// import 'route_management/bus_register.dart';
// import 'route_management/route_register.dart';
// import 'user_management/driver_registration.dart';
// import 'user_management/studentandparent_registration.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<AuthService>(create: (_) => AuthService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false ,
        title: 'school bus tracker',
        theme: ThemeData(
          
          primarySwatch: Colors.deepPurple,
        ),
        home:Wrapper()
        
      ),
    );
  }
}

