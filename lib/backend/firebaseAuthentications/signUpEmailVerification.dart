import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home.dart';
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
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      customSnackbar(context,e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        return checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

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
                        onPressed:
                            canResendEmail ? sendVerificationEmail : () {},
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
  }
}
