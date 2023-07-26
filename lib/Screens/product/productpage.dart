import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/homePageAppBar.dart';
import 'package:flutter_auth/Screens/home/sideBarMenu.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        endDrawer: SideBarMenu(),
        body: Column(children: [
          /// Dashboard appbar
          HomePageAppBar(),
        ]));
  }
}
