/// this is the product card

import 'package:flutter/material.dart';
import 'package:flutter_auth/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String imgLink;
  ProductCard({required this.imgLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 200,
            child: Center(
              child: Image.network(imgLink),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Title",
                      style: GoogleFonts.getFont('Poppins',
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 3),
                    child: Text("Rs. 230",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        )),
                  ),
                  Row(children: [
                    Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "Location of selling",
                      style: GoogleFonts.getFont("Poppins", fontSize: 12),
                    )
                  ])
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.shopping_cart_checkout,
                  color: Color(0xffffffff),
                ),
                style: ButtonStyle(
                  // textStyle: MaterialStateProperty.all(),
                  backgroundColor: MaterialStateProperty.all(Color(0xff000000)),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  enableFeedback: true,
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Color(0xff000000),
                      width: 1,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  ButtonStyle CustomElevatedBtnStyle() {
    return ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.hovered)) {
            return primaryColor.withOpacity(0.5); // set the hover color here
          }
          if (states.contains(MaterialState.pressed)) {
            return primaryColor;
          }
          return primaryColor;
        }),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  }
}
