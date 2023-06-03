import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/profile/profile.dart';

class SideBarMenu extends StatefulWidget {
  SideBarMenu({Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: const Center(child: Text('SignIn/SignUp')),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return LoginScreen();
            })));
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: const Center(child: Text('Profile')),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(context, MaterialPageRoute(builder: ((context) {
          
              return  ProfileScreen();
            })));
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: const Center(child: Text('Settings')),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: const Center(child: Text('About Our Team')),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}