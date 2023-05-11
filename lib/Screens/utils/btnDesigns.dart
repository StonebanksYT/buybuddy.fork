import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/profileConstants.dart';
ButtonStyle CustomElevatedBtnStyle() {
  return ButtonStyle(
    shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.hovered)) {
          return secondary; // set the hover color here
        }
        if (states.contains(MaterialState.pressed)) {
          return primary; // set the hover color here
        }
        return primary;
      }),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
}

