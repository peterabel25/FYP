// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Students List") ,
        centerTitle:true ,
      ) ,
      body:Center(child: Text("List of students assigned to bus ....")) ,
    );
  }
}