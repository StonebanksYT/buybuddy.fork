import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:get/get.dart';

class FirebaseLogin {
  TextEditingController emailController;
  TextEditingController passwordController;
  UserIdController userIdController;
  BuildContext context;
  BuildContext snackContext;
  FirebaseLogin(
      {required this.emailController,
      required this.passwordController,
      required this.snackContext,
      required this.context,
      required this.userIdController});
    Controller controller=Get.find<Controller>();
  Future<void> firebaseLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      userIdController.setUserId(credential.user!.uid);
      print(credential.user!.uid);
      // NrT25T1JVoa6FEFZjjyswV7zI5A3
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
      controller.setloginLoading(false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customSnackBar(snackContext, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        customSnackBar(snackContext, "Wrong password provided for that user.");
      }
    }
  }
}
