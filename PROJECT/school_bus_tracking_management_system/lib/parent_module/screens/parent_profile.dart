// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Setup your profile") ,
        centerTitle:true ,
      ) ,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(child: 
            Column(
              children: [
                
                CircleAvatar(
                  backgroundColor:Colors.grey[400] ,
                  radius:55 ,
                  child:Icon(Icons.add_a_photo,size:30 ,) ,
      
                ),
                SizedBox(
                  height:15 ,
                ),
      TextFormField(
                      decoration: InputDecoration(
                          hintText: "pickup point",
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          )),
                    ),
                    SizedBox(
                  height:15 ,
                ),
      TextFormField(
                       obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          )),
                    ),
                    SizedBox(
                  height:15 ,
                ),
      
      TextFormField(
         obscureText: true,
                      decoration: InputDecoration(
                          hintText: "confirm password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          )),
                    ),
      
      SizedBox(
                  height:15 ,
                ),
      
                 ElevatedButton(
                        onPressed: () async {
                         
          final snackBar = SnackBar(
        content: Text('profile updated'),
        duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                          minimumSize: Size(160, 43),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                        )),
      
              ],
            )
            ),
          ),
        ),
      ) ,
    );
  }
}