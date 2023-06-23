import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseLogin {
  TextEditingController emailController;
  TextEditingController passwordController;
  BuildContext context;

  FirebaseLogin({
    required this.emailController,
    required this.passwordController,
    required this.context,
  });
  Future<void> firebaseLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      controller.setUserId(credential.user!.uid);
      print(credential.user!.uid);
      Navigator.pushNamed(context, '/home');
      controller.setloginLoading(false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        customSnackbar(context, "Wrong password provided for that user.");
      }
    }
  }
}
