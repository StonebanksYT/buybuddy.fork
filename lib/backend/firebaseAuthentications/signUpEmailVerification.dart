import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  late Timer? timer;
  bool canResendEmail = false;
  Future sendVerificationEmail() async {
=======
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
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });

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

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomePage()
        : Scaffold(
            appBar: AppBar(title: const Text("Email Verification")),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const Text(
                  "A verification email has been sent",
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.email),
                    label: const Text("Resend Email"),
                    onPressed: canResendEmail ? sendVerificationEmail : () {},
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: TextButton(
                    child: const Text("Cancel"),
                    onPressed: () async {
                      return await FirebaseAuth.instance.signOut();
                    },
                  ),
                )
              ]),
            ),
          );
    if (controller.isEmailVerified.value) timer?.cancel();
  }
}