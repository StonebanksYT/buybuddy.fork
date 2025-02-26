/// Personal Info includes User name, email,language, institute type, institute name, institute location,ways to contact

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/profile/profileEdit/profileEdit.dart';
import 'package:flutter_auth/Screens/utils/textDesigns.dart';
import 'package:flutter_auth/controllers/controllerCall.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:get/get.dart';
import '../profileutils/profileConstants.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setInstituteType(controller.userModel.value.instituteType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(
          text: "Personal information",
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "Manage your personal information with ease",
          textColor: const Color.fromARGB(255, 116, 116, 116),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Obx(
              () => CustomCard(
                controller: controller,
                title: "Name",
                titleValue:
                    "${controller.userModel.value.firstName} ${controller.userModel.value.lastName}",
                icon: Icons.person_2_outlined,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => CustomCard(
                controller: controller,
                title: "Contact Details",
                titleValue:
                    "${controller.userModel.value.email}\n${controller.userModel.value.mobileNumber}",
                icon: Icons.connect_without_contact_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Obx(() {
              return CustomCard(
                  controller: controller,
                  title: "Institute Type",
                  titleValue: controller.userModel.value.instituteType[0]
                          .toUpperCase() +
                      controller.userModel.value.instituteType.substring(1),
                  icon: Icons.school_outlined);
            }),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => CustomCard(
                  controller: controller,
                  title: "Institute Name",
                  titleValue: controller.userModel.value.instituteName,
                  icon: Icons.location_city_outlined),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Obx(
              () => CustomCard(
                  controller: controller,
                  title: "Institute Location",
                  titleValue: controller.userModel.value.instituteLocation,
                  icon: Icons.place_outlined),
            ),
            CustomCard(
                controller: controller,
                title: "Languages",
                titleValue: "English, Hindi",
                icon: Icons.language_outlined),
          ],
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  String title;
  String titleValue;
  IconData icon;
  Controller controller;
  CustomCard(
      {Key? key,
      required this.title,
      required this.titleValue,
      required this.icon,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
          height: 125,

          /// added inkwell just for future animation purpose
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditProfileDialog(
                      instituteLocation:
                          controller.userModel.value.instituteLocation,
                      instituteName: controller.userModel.value.instituteName,
                      language: "English, Hindi",
                      mobileNumber: controller.userModel.value.mobileNumber,
                      email: controller.userModel.value.email,
                      firstName: controller.userModel.value.firstName,
                      lastName: controller.userModel.value.lastName,
                    );
                  });
            },
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 224, 224, 224))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          Icon(
                            icon,
                            color: primary,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: titleValue,
                        fontSize: 15,
                        textColor: Colors.grey,
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
// import 'package:flutter_auth/controllers/controllers.dart';
// import 'package:get/get.dart';

// class PersonalInfo extends StatelessWidget {
//   PersonalInfo({Key? key}) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [Obx(() => Text(controller.userModel.value.instituteName))],
//     );
//   }
// }
