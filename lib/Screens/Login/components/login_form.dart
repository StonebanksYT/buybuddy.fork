import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:get/get.dart';
import '../../home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/Screens/utils/customField.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UserIdController userIdController = Get.put(UserIdController());

  @override
  Widget build(BuildContext context) {
    print("on login form");
    BuildContext SnackContext = context;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Container(
      width: 410,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140,
            child: Column(children: [
              Text(
                "Sign In to buyBuddy",
                style: GoogleFonts.getFont("Ramabhadra",
                    fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              GoogleConnect(isLogin: true,onTap: (){})
            ]),
          ),
          // Or element
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 180,
              height: 1,
              color: const Color.fromARGB(255, 197, 197, 197),
              padding: const EdgeInsets.only(bottom: 5),
            ),
            const Text(
              "Or",
              style: TextStyle(color: Color.fromARGB(255, 142, 142, 142)),
            ),
            Container(
              width: 180,
              height: 1,
              color: const Color.fromARGB(255, 197, 197, 197),
              padding: const EdgeInsets.only(bottom: 5),
            )
          ]),

          Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                      validator: (value) {
                        print("email field");
                        if (value!.isEmpty) {
                          return 'Email is required.';
                        } else if (!Validations.isEmail(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      width: 410,
                      FieldName: "Email",
                      isObscure: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      textInputAction: TextInputAction.next),
                  CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password is required.';
                        } else if (!Validations.validatePassword(value)) {
                          return 'Please enter a valid password. Password must include atleast 1 special character, capital letter,number';
                        }
                        return null;
                      },
                      width: 410,
                      FieldName: "Password",
                      isObscure: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      textInputAction: TextInputAction.done),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                  userIdController.setUserId(credential.user!.uid);
                  // print(credential.user!.uid);
                  // NyCROzsBnsSsyE6LvbmjpONECjt2
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    customSnackBar(
                        SnackContext, "No user found for that email.");
                  } else if (e.code == 'wrong-password') {
                    customSnackBar(
                        SnackContext, "Wrong password provided for that user.");
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Color(0xff002aff), width: 2)),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white),
              child: const Text(
                "Login",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
