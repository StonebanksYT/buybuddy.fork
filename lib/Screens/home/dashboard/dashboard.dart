import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboardUtils.dart';
class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Text("Dashboard"),
          // // Generated code for this Row Widget...
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 262,
                  height: 500,
                  color: Colors.green,
                ),
                   Container(
                    height: 400,
                    color: Color.fromARGB(255, 159, 43, 43),
                    child:GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
                      
                      return Container(width: 100,height: 100,color: Colors.green,);
                    },)),
                  
                // Expanded(
                //   child: Container(
                //     width: 500,
                //     color: Colors.white,
                //     child: GridView.builder(
                //       padding: EdgeInsets.zero,
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 3,
                //         crossAxisSpacing: 10,
                //         mainAxisSpacing: 10,
                //         childAspectRatio: 1,
                //       ),
                //       shrinkWrap: true,
                //       scrollDirection: Axis.vertical,
                //       itemBuilder: (context, index) {
                //         return ProductCard();
                //       },
                //     ),
                //   ),
                // ),
                Container(
                  width: 258,
                  height: 500,
                  color: Colors.blue,
                ),
              ],
            ),
          )
        
        ],
      ),
    );
  }
}
