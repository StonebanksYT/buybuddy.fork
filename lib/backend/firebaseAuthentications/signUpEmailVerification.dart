import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class FirebaseEmailVerification{
  FirebaseEmailVerification();
  /// Sends a verification email to the currently logged-in user.
  /// Sets the state to disable the resend button temporarily and enables it again after 5 seconds.
  /// Displays a snackbar with an error message if an error occurs.
  Controller controller=Get.put(Controller());
  Future<void> sendVerificationEmail(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      // Send the verification email
      await user.sendEmailVerification();

      // Disable the resend button temporarily
    //  controller.setCanResendEmail(false);

      // Wait for 5 seconds
      await Future.delayed(Duration(seconds: 5),() {
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        },));
      },);

      // // Enable the resend button again
      //      controller.setCanResendEmail(true);

    } catch (e) {
      // Display snackbar with error message
      customSnackBar(context, e.toString());
    }
  }
  // Future cancelBtn()async{
  //   return await FirebaseAuth.instance.signOut();
  // }
  Future checkEmailVerified(timer) async {
    await FirebaseAuth.instance.currentUser!.reload();
         controller.setisEmailVerified(FirebaseAuth.instance.currentUser!.emailVerified);

    if (controller.isEmailVerified.value) timer?.cancel();
  }
}