import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboardUtils.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController searchBarController = TextEditingController();
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(spreadRadius: 0, color: Colors.transparent)
          ],
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5)),
          color: Colors.white),
      height: 70,
      child: Row(children: [
        const SizedBox(
          width: 20,
        ),
        TextButton(
            onPressed: () {Navigator.pushNamed(context, '/home');},
            child: Text(
              "BuyBuddy",
              style: GoogleFonts.getFont("Poppins",
                  fontSize: 20, color: Colors.black),
            )),
        SizedBox(
          width: size.width * 0.45,
        ),
        Container(
          width: 300,
          height: 38,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: SearchField(
            controller: searchBarController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            hintText: "Search",
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        SizedBox(
            width: 100,
            height: 40,
            child: CustomTabButton(
              icon: Icons.home,
              tabName: "Home",
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
            )),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
            width: 100,
            height: 40,
            child: CustomTabButton(
              icon: Icons.shopping_cart_checkout_outlined,
              tabName: "Cart",
            )),
        const SizedBox(
          width: 80,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey,
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO0u4dr5oCgDbhigc4GH5o4PMEZGwVaHabRg&usqp=CAU",
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              "Honey Bansal",
              style: GoogleFonts.getFont("Poppins", color: Colors.black),
            )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(onTap: () {}, child: const Icon(Icons.menu))
      ]),
    );
  }
}
