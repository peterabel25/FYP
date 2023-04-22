// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'authentication/login_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'parent_module/providers/user_data_provider.dart';
//import 'parent_module/authentication/login_page.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: const MyApp()));
  //runApp(const MyApp());
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
        home: LoginPage());
  }






  
}
