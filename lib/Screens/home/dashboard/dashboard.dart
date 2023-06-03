import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/appbar/dashboardAppBar.dart';
import 'package:flutter_auth/Screens/home/dashboard/filterSide/filter.dart';
import 'package:flutter_auth/Screens/home/dashboard/productSection/productCard.dart';
import 'package:flutter_auth/Screens/home/dashboard/productSection/productConstants.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("dashboard build");
    return Scaffold(
      body: Column(
        children: [
          /// Dashboard appbar
          const DashboardAppBar(),

          /// Main Dashboard which have filters, products, ads sections
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// this is the main filter container in which all types of filters exists
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.3,
                              color: Colors.grey.withOpacity(0.5)))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// this is the product category filter section
                        filterHeading("Categories"),
                        CategorySelectionPage(),

                        /// Border line
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 0, color: Colors.transparent)
                              ],
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5))),
                        ),

                        /// this is the location filter
                        filterHeading("Location"),
                        LocationFilterPage()
                      ],
                    ),
                  ),
                ),

                /// This expanded holds both the products and ads section
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // product section
                        SizedBox(
                          width: size.width - 500,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisExtent: 330),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productImgLink.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                imgLink: productImgLink[index],
                              );
                            },
                          ),
                        ),

                        /// ads section
                        Container(
                          width: 300,
                          color: const Color(0xffdfdfdc),
                          child: const Column(
                            children: [
                              Text('Right Column'),
                              SizedBox(height: 600),
                              Text('Item 1'),
                              SizedBox(height: 20),
                              Text('Item 2'),
                              SizedBox(height: 20),
                              Text('Item 3'),
                              SizedBox(height: 20),
                              Text('Item 4'),
                              SizedBox(height: 20),
                              Text('Item 5'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filterHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8),
      child: Text(
        heading,
        style: GoogleFonts.getFont("Poppins",
            fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
