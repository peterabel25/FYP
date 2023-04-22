// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text('view current bus location'))
    );
  }
}
