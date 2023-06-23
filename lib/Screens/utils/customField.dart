import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'package:flutter_auth/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final String FieldName;
  final bool isObscure;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.validator,
    required this.width,
    required this.FieldName,
    required this.isObscure,
    required this.keyboardType,
    required this.controller,
    required this.textInputAction,
    this.onChanged,
    this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          FieldName,
          style: GoogleFonts.getFont("Nunito",
              fontSize: 15, fontWeight: FontWeight.bold),
        ),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            obscureText: isObscure,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            onChanged: onChanged,
            cursorWidth: 1,
            validator: validator,
            decoration: InputDecoration(
                helperText: " ",
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xff0033ff),
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(bottom: 7, left: 10),
                filled: true,
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 240, 8, 8),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: textFilledColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xff0033ff),
                    width: 2.0,
                  ),
                ),
                fillColor: textFilledColor,
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 195, 195, 195))))
      ]),
    );
  }
}

class PasswordField extends StatelessWidget {
  final double width;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController passwordcontroller;

  const PasswordField({
    Key? key,
    required this.width,
    required this.textInputAction,
    required this.passwordcontroller,
    this.onChanged,
    this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: GoogleFonts.getFont(
                'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordcontroller,
              obscureText: controller.isObscure.value,
              textInputAction: textInputAction,
              cursorColor: Colors.black,
              onChanged: onChanged,
              cursorWidth: 1,
              validator: validator,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                helperText: ' ',
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xff0033ff),
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(bottom: 7, left: 10),
                filled: true,
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 240, 8, 8),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: textFilledColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xff0033ff),
                    width: 2.0,
                  ),
                ),
                fillColor: textFilledColor,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 195, 195, 195),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isObscure.toggle();
                  },
                  icon: Icon(
                    controller.isObscure.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
