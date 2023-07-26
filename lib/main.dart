import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/firebase_options.dart';
import 'package:flutter_auth/routegenerator.dart';
import 'package:get/get.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Controller controller1 = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    print("on main.dart");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buy Buddy',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
