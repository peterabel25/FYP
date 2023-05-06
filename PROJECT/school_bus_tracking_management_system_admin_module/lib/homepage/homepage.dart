// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:school_bus_tracking_management_system_admin_module/authentication/usermodal.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/user_auth_and_registration_service.dart';
import 'package:school_bus_tracking_management_system_admin_module/notifications/notifications_page.dart';
import 'package:school_bus_tracking_management_system_admin_module/route_management/route_management.dart';
import 'package:school_bus_tracking_management_system_admin_module/user_management/user_management.dart';
import 'package:side_navigation/side_navigation.dart';

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
    Center(
      child: Text("Settings"),
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context); 
    auth.User? user = auth.FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("School bus Tracker")),
        body: Row(
          children: [
            SideNavigationBar(
                header: SideNavigationBarHeader(
                    image: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person,size:40),
                    ),
                    title: Text("School Admin",style:TextStyle(fontSize:18 ) ,),
                    
                    subtitle:Text("Admin@email.com")),
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
                  SideNavigationBarItem(
                      icon: Icons.settings, label: "Settings"),
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
