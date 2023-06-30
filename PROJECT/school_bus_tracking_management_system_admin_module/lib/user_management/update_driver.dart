// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../authentication/user_auth_and_registration_service.dart';

class UpdateDriverInfo extends StatefulWidget {
  const UpdateDriverInfo({super.key});

  @override
  State<UpdateDriverInfo> createState() => _UpdateDriverInfoState();
}

class _UpdateDriverInfoState extends State<UpdateDriverInfo> {
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registered Drivers'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('userRecords')
            .where('role', isEqualTo: 'driver')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

final driverDocs = snapshot.data!.docs;

          return DataTable(
            columns: [
              DataColumn(label: Text('First Name')),
              DataColumn(label: Text('Last Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('License Number')),
              DataColumn(label: Text('Bus Assigned')),
              DataColumn(label: Text('')),
            ],
            rows: driverDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return DataRow(cells: [
                DataCell(Text(data['firstName'])),
                DataCell(Text(data['lastName'])),
                DataCell(Text(data['email'])),
                DataCell(Text(data['contact'])),
                DataCell(Text(data['licenseNo'])),
                DataCell(Text(data['busAssigned'])),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          authservice.deleteRegisteredUser(
                              data['email'], data['password']);

                          authservice.deleteUserData(document.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 233, 38, 24),
                        ),
                        child: Text("Delete")),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
//function
                        void openEditDialog(Map<String, dynamic> data) {
                          //final authservice = Provider.of<AuthService>(context);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Extract initial values from the data map
                              String firstName = data['firstName'];
                              String lastName = data['lastName'];
                              String email = data['email'];
                              String contact = data['contact'];
                              String licenseno = data['licenseNo'];
                              String busAssigned = data['busAssigned'];

                              // Set initial values for text form fields
                              TextEditingController firstNameController =
                                  TextEditingController(text: firstName);
                              TextEditingController lastNameController =
                                  TextEditingController(text: lastName);
                              TextEditingController emailController =
                                  TextEditingController(text: email);
                              TextEditingController contactController =
                                  TextEditingController(text: contact);
                              TextEditingController licenseController =
                                  TextEditingController(text:licenseno);
                              TextEditingController busAssignedController =
                                  TextEditingController(text: busAssigned);

                              return AlertDialog(
                                title: Text('Edit Driver'),
                                content: Column(
                                  children: [
                                    TextFormField(
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                          labelText: 'First Name'),
                                    ),
                                    TextFormField(
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                          labelText: 'Last Name'),
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      decoration:
                                          InputDecoration(labelText: 'Email'),
                                    ),
                                    TextFormField(
                                      controller: contactController,
                                      decoration:
                                          InputDecoration(labelText: 'Contact'),
                                    ),
                                    TextFormField(
                                      controller: licenseController,
                                      decoration: InputDecoration(
                                          labelText: 'License Number'),
                                    ),
                                    TextFormField(
                                      controller: busAssignedController,
                                      decoration: InputDecoration(
                                          labelText: 'Bus Assigned'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle save button press
                                      String updatedFirstName =
                                          firstNameController.text;
                                      String updatedLastName =
                                          lastNameController.text;
                                      String updatedEmail =
                                          emailController.text;
                                      String updatedContact =
                                          contactController.text;
                                      // String updatedResidence =
                                      //     residenceController.text;
                                      String updatedBusAssigned =
                                          busAssignedController.text;

                                      // Update the user's data
                                      authservice.updateDriverData(
                                          document.id,
                                          updatedFirstName,
                                          updatedLastName,
                                          updatedEmail,
                                          updatedContact,
                                         // updatedResidence,
                                          updatedBusAssigned);

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        openEditDialog(data);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 42, 148, 45),
                      ),
                      child: Text("Edit"),
                    ),
                  ],
                )),
              ]);
          
            }).toList(),
          );
        },
      ),
    );
  }
}
