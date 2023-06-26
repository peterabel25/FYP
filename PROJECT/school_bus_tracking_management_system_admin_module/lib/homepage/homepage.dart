// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_local_variable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/user_auth_and_registration_service.dart';
import 'package:school_bus_tracking_management_system_admin_module/notifications/notifications_page.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/route_management.dart';
import 'package:school_bus_tracking_management_system_admin_module/user_management/user_management.dart';
import 'package:side_navigation/side_navigation.dart';

import '../providers/admin_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> views = [
    UserManagementPage(),
    RouteManagementPage(),
    NotificationsPage(),
    // Center(
    //   child: Text("Settings"),
    // ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final adminprovider = Provider.of<AdminProvider>(context);

    return Scaffold(
        appBar: AppBar(
            actions: [
              Icon(Icons.notifications, 
              ),
              SizedBox(width: 10),
              Icon(Icons.chat,),
              SizedBox(width: 10),
              Icon(Icons.person,),
              SizedBox(width: 15),
            ],
            //leading:Image.asset("assets/childandparent.jpg",width:50,height:30),
            //backgroundColor: Colors.grey[200],
            title: Text("SBTMS",
                style: TextStyle(
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        body: Row(
          children: [
            SideNavigationBar(
            //  header:SideNavigationBarHeader(image:Image.asset("assets/childandparent.jpg",width:50,height:30) , title:Text(""),subtitle:Text("")),
                initiallyExpanded: true,
                footer: SideNavigationBarFooter(
                    label: InkWell(
                        onTap: () async {
                          await authservice.signOut();
                        },
                        child: Text("LogOut"))),
                selectedIndex: selectedIndex,
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  SideNavigationBarItem(
                      icon: Icons.account_circle, label: "User Management"),
                  SideNavigationBarItem(
                      icon: Icons.telegram, label: "Route Management"),
                  SideNavigationBarItem(
                      icon: Icons.notifications_active, label: "Notifications"),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }),
            Expanded(child: views.elementAt(selectedIndex)),
          ],
        ));
  }
}


