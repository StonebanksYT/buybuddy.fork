import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'sideBarMenu.dart';
import 'homePageAppBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // endDrawer: SideBarMenu(),
      backgroundColor: Color(0xffffffff),
      body: 
      // Column(
        // children: [HomePageAppBar(), 
      DashBoard()
      // ]),
    );
  }
}
