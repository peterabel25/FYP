// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ViewRoute extends StatefulWidget {
  const ViewRoute({Key? key}) : super(key: key);

  @override
  State<ViewRoute> createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text("A map to display bus movement + student's pickup points") 
      ),
    );
  }
}
