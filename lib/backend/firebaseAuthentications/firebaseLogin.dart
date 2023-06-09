import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:flutter_auth/models/userModel.dart';
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
  Controller controller = Get.find<Controller>();

  Future<void> firebaseLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      userIdController.setUserId(credential.user!.uid);
      print(credential.user!.uid);
      // NrT25T1JVoa6FEFZjjyswV7zI5A3
      Navigator.pushNamed(context, '/home');
      controller.setloginLoading(false);
      User? user = credential.user;
      if (user != null && user.emailVerified == true) {
        userIdController.setUserId(credential.user!.uid);
        print(credential.user!.uid);
        // NrT25T1JVoa6FEFZjjyswV7zI5A3
        try {
          /// fetching user data corresponding to the user currently logged in
          DatabaseReference userRef = FirebaseDatabase.instance
              .ref()
              .child("users")
              .child(userIdController.userid.value);

          /// delaying the execution of the code until the userRef has completed its operation
          await Future.delayed(Duration.zero, () {
            userRef.onValue.listen((event) {
              Object? data = event.snapshot.value;
              Map<String, dynamic> dataMap = data as Map<String, dynamic>;
              // storing profile information from firebase into controller
              controller.setUserModel(UserModel(
                  firstName:
                      "${dataMap["firstName"][0].toUpperCase() + dataMap["firstName"].substring(1)}",
                  lastName:
                      "${dataMap["lastName"][0].toUpperCase() + dataMap["lastName"].substring(1)}",
                  mobileNumber: dataMap["mobileNumber"],
                  email: dataMap["email"],
                  instituteType: dataMap["instituteType"],
                  instituteName:
                      "${dataMap["instituteName"][0].toUpperCase() + dataMap["instituteName"].substring(1)}",
                  instituteLocation:
                      "${dataMap["instituteLocation"][0].toUpperCase() + dataMap["instituteLocation"].substring(1)}"));
            });
          });
        } catch (e) {
          Text("${e}");
        }
        {
          Container(
            child: Text("empty container"),
          );
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
        controller.setloginLoading(false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customSnackBar(snackContext, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        customSnackBar(snackContext, "Wrong password provided for that user.");
      }
    }
  }
}
