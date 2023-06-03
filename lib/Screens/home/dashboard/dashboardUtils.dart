import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String? hintText;
  final TextEditingController controller;
  SearchField(
      {Key? key,
      required this.keyboardType,
      required this.controller,
      required this.textInputAction,
      this.onChanged,
      this.hintText})
      : super(key: key);
  final Color textFilledColor = const Color(0xfff1f1f1);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        onChanged: onChanged,
        cursorWidth: 1,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hoverColor: Colors.transparent,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 240, 8, 8),
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.only(bottom: 7, left: 10),
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 240, 8, 8),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: textFilledColor,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: textFilledColor,
                width: 2.0,
              ),
            ),
            fillColor: textFilledColor,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 195, 195, 195))));
  }
}

class CustomTabButton extends StatelessWidget {
  final String tabName;
  final IconData icon;
  CustomTabButton({required this.tabName, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shadowColor: MaterialStateProperty.all(Colors.transparent)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text(
              tabName,
              style: GoogleFonts.getFont("Poppins",
                  textStyle: TextStyle(color: Colors.black)),
            )
          ],
        ));
  }
}
