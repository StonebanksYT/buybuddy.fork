import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home.dart';
import "package:flutter_auth/backend/firebaseAuthentications/signUpEmailVerification.dart";
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:get/get.dart';
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer? timer;
  Controller controller=Get.put(Controller());
  

  @override
  void initState() {
    super.initState();
    controller.isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!controller.isEmailVerified.value) {
      FirebaseEmailVerification().sendVerificationEmail(context);
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        return FirebaseEmailVerification().checkEmailVerified(timer);
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return controller.isEmailVerified.value
        ? HomePage()
        : Scaffold(
            appBar: AppBar(title: const Text("Email Verification")),
            body: Center(
              child: Column(children: [
               Obx(() {
                  return Text("A verification email has been sent to ${controller.userModel.value.email}");
               }),
                // SizedBox(
                //   height: 30,
                //   width: 100,
                //   child: ElevatedButton.icon(
                //     icon: const Icon(Icons.email),
                //     label: const Text("Resend Email"),
                //     onPressed:()async{
                //        controller.canResendEmail.value ? FirebaseEmailVerification().sendVerificationEmail(context) : () {};
                //     },
                //   ),
                // ),
               

                // SizedBox(
                //   height: 30,
                //   width: 100,
                //   child: TextButton(
                //     child: Text("Cancel"),
                //     onPressed: () async {
                //       customSnackBar(context, "Email not verified");
                //       FirebaseEmailVerification().cancelBtn();
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // )
            
              ]),
            ),
          );
  }
}
