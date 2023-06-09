///The LoginForm widget is a stateful widget that contains a form with two text fields for email and password. The email field is validated to ensure that it is not empty and is a valid email address. The password field is also validated to ensure that it is not empty and includes at least one special character, capital letter, and number.

// The form is wrapped in a SingleChildScrollView widget to allow for scrolling. The ElevatedButton widget is used to submit the form and authenticate the user. If the authentication is successful, the user is redirected to the HomePage widget. If there is an error, a customSnackBar is displayed to inform the user of the error.

// The LoginForm widget also uses the UserIdController to set the user ID after successful authentication. The GoogleConnect widget is also included to allow the user to sign in with their Google account.
import 'package:flutter/material.dart';
import 'package:flutter_auth/backend/firebaseAuthentications/firebaseLogin.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/Screens/utils/customField.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpComponents.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final  UserIdController userIdController = Get.put(UserIdController());
 final Controller controller=Get.put(Controller());
 var emailController = TextEditingController();
    var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("on login form");
    BuildContext SnackContext = context;
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
            child: ElevatedButton(onPressed: ()async{
               controller.setloginLoading(true);
                await FirebaseLogin(emailController: emailController, passwordController: passwordController, snackContext: SnackContext, context: context, userIdController: userIdController).firebaseLogin();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Color(0xff002aff), width: 2)),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white),
              child: controller.loginLoading.value ? const CircularProgressIndicator():const  Text(
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
