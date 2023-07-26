///The LoginForm widget is a stateful widget that contains a form with two text fields for email and password. The email field is validated to ensure that it is not empty and is a valid email address. The password field is also validated to ensure that it is not empty and includes at least one special character, capital letter, and number.

// The form is wrapped in a SingleChildScrollView widget to allow for scrolling. The ElevatedButton widget is used to submit the form and authenticate the user. If the authentication is successful, the user is redirected to the HomePage widget. If there is an error, a customSnackBar is displayed to inform the user of the error.

// ignore_for_file: unused_import

// The LoginForm widget also uses the UserIdController to set the user ID after successful authentication. The GoogleConnect widget is also included to allow the user to sign in with their Google account.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/backend/firebaseAuthentications/firebaseLogin.dart';
import 'package:flutter_auth/controllers/controllerCall.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';
import '../../home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/Screens/utils/customField.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Controller controller = Get.put(Controller());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    print("on login form");
    BuildContext SnackContext = context;
    // List firebaseLoginParameters=[emailController,passwordController,context,SnackContext];
    return SizedBox(
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
              GoogleConnect(isLogin: true, onTap: () {})
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
                  PasswordField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password is required.';
                        } else if (!Validations.validatePassword(value)) {
                          return 'Please enter a valid password. Password must include atleast 1 special character, capital letter,number';
                        }
                        return null;
                      },
                      width: 410,
                      passwordcontroller: passwordController,
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
                controller.setloginLoading(true);
                await FirebaseLogin(
                        emailController: emailController,
                        passwordController: passwordController,
                        context: SnackContext,
                       )
                    .firebaseLogin();
                // if(auth.currentUser != null){
                //   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const EmailVerificationScreen()));
                // }
                // setState(() {
                //   _isLoading = false;
                // });
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Color(0xff002aff), width: 2)),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white),
              child: controller.loginLoading.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
void fetchUserModel(String userId) async {
  try {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    print(doc.data());
    // Map<dynamic, dynamic> temp = doc.data() as Map<dynamic, dynamic>;
    if (doc.exists) {
      print("${doc.data().runtimeType}");
      UserModel user = UserModel.fromFirestore(doc);
      // Use the fetched UserModel object as needed
      controller.setUserModel(user);
      print("user set");
      // controller.setUserEmail(userModel.email);
    } else {
      print('User document does not exist');
    }
  } catch (e) {
    print('Error fetching UserModel: $e');
  }
}
