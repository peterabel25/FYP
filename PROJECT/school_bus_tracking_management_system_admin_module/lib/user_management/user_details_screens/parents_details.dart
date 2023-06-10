 // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

 import 'package:flutter/material.dart';

class ParentsDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const ParentsDetails({required this.data});

  @override
  State<ParentsDetails> createState() => _ParentsDetailsState();
}

class _ParentsDetailsState extends State<ParentsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                child: Icon(Icons.person, size: 50.0),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'First Name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.data['firstName'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'Last Name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.data['lastName'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.data['email'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'Contact:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.data['contact'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'Residence:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.data['residence'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
