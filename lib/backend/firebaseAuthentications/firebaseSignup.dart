import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/backend/firebaseAuthentications/signUpEmailVerification.dart';
import 'package:flutter_auth/Screens/emailVerificationScreen/emailVerification.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:get/get.dart';

class FirebaseSignUp {
  String emailAddress;
  String password;
  UserIdController userIdController;
  String firstName;
  String lastName;
  String mobileNumber;
  String instituteType;
  String instituteName;
  String instituteLocation;
  BuildContext context;
  FirebaseSignUp({
    required this.context,
    required this.emailAddress,
    required this.firstName,
    required this.instituteLocation,
    required this.instituteName,
    required this.instituteType,
    required this.lastName,
    required this.mobileNumber,
    required this.password,
    required this.userIdController,
  });
  Controller controller = Get.find<Controller>();
  Future<void> firebaseSignUp() async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users');
      String uid = credential.user!.uid;
      userIdController.setUserId(uid);
      await userRef.child(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': emailAddress,
        'mobileNumber': mobileNumber,
        'instituteType': controller.instituteType.value,
        'instituteName': instituteName,
        'instituteLocation': instituteLocation,
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const EmailVerificationScreen();
      }));
      controller.setsignUpLoading(false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const SnackBar(content: Text('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        const SnackBar(
            content: Text('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
    }
  }
}
