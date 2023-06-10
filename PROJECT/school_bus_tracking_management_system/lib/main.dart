// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system/authentication/splash_screen.dart';
import 'authentication/login_page.dart';
import 'driver_module/driver_data_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'parent_module/providers/parent_data_provider.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => DriverData()),
      ],
      child: const MyApp()));
  
}






class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: SplashScreen());
  }






  
}
