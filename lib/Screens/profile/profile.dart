import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_auth/Screens/profile/profileEdit/profileEdit.dart';
import 'package:flutter_auth/backend/firebaseAuthentications/firebaseProfile.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/homePageAppBar.dart';
import 'package:flutter_auth/Screens/home/sideBarMenu.dart';
import 'package:flutter_auth/Screens/profile/tabs/personalInfo.dart';
import 'package:flutter_auth/controllers/visibilityController.dart';
import 'package:flutter_auth/Screens/profile/tabs/yourOrders.dart';
import 'package:flutter_auth/Screens/profile/tabs/yourProducts.dart';
import 'package:flutter_auth/Screens/utils/btnDesigns.dart';
import 'package:flutter_auth/Screens/utils/textDesigns.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';
import 'profileutils/profileComponents.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Variables
  Uint8List? imageFile = Uint8List(2);
  late String? profileimg;
  VisibilityController visibilityController = Get.put(VisibilityController());
  Controller controller = Get.put(Controller());

  UserIdController userIdController = Get.put(UserIdController());
  List<Widget> pages = [
    PersonalInfo(),
    const YourOrders(),
    const YourProducts()
  ];
  Future<void> chooseProfilePicture() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
        allowMultiple: false,
      );
      imageFile = result!.files.first.bytes;
      String profilePictureUrl =
          await profileStorage().uploadFile(imageFile, result.files.first.name);

      // Upload the selected image file to Firebase Storage and update the profile picture URL in the database
      // String profilePictureUrl = await uploadProfilePicture(imageFile);

      profileStorage().saveProfilePictureUrl(profilePictureUrl);

      // Refresh the profile screen to reflect the updated profile picture
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  /// since the data is getting fetched from firebase realtime database, a future method is used to wait for the data
  Future<Widget> profileScreen() async {
    try {
      Controller controller = Get.put(Controller());
      UserIdController userIdController = Get.put(UserIdController());
      profileimg = await profileStorage().fetchProfileImageUrl();
      print(profileimg);

      /// fetching user data corresponding to the user currently logged in
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(userIdController.userid.value);

      /// delaying the execution of the code until the userRef has completed its operation
      await Future.delayed(Duration.zero, () {
        userRef.onValue.listen((event) {
          Object? data = event.snapshot.value;
          Map<String, dynamic> dataMap = data as Map<String, dynamic>;
          // storing profile information from firebase into controller
          controller.setProfileimg(profileimg!);
          controller.setUserModel(UserModel(
              firstName:
                  "${dataMap["firstName"][0].toUpperCase() + dataMap["firstName"].substring(1)}",
              lastName:
                  "${dataMap["lastName"][0].toUpperCase() + dataMap["lastName"].substring(1)}",
              mobileNumber: dataMap["mobileNumber"],
              email: dataMap["email"],
              instituteType: dataMap["instituteType"],
              instituteName:
                  "${dataMap["instituteName"][0].toUpperCase() + dataMap["instituteName"].substring(1)}",
              instituteLocation:
                  "${dataMap["instituteLocation"][0].toUpperCase() + dataMap["instituteLocation"].substring(1)}",
              profileimg: profileimg));
        });
      });
    } catch (e) {
      Text("$e");
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        /// taking homePage function as future value which contains data of homepage function
        future: profileScreen(),
        builder: (context, snapshot) {
          /// Future with no errors
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            final data = snapshot.data;
            if (data == null) {
              return Container(
                child: const Text('Empty loaded'),
              );
            } else {
              return Scaffold(
                backgroundColor: const Color.fromRGBO(245, 247, 248, 1),
                endDrawer: const SideBarMenu(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HomePageAppBar(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(230, 20, 230, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("buyBuddy Account",
                                        style: GoogleFonts.getFont(
                                          "Nunito",
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return EditProfileDialog(
                                                          instituteLocation:
                                                              controller
                                                                  .userModel
                                                                  .value
                                                                  .instituteLocation,
                                                          instituteName:
                                                              controller
                                                                  .userModel
                                                                  .value
                                                                  .instituteName,
                                                          language:
                                                              "English, Hindi",
                                                          mobileNumber:
                                                              controller
                                                                  .userModel
                                                                  .value
                                                                  .mobileNumber,
                                                          email: controller
                                                              .userModel
                                                              .value
                                                              .email,
                                                          firstName: controller
                                                              .userModel
                                                              .value
                                                              .firstName,
                                                          lastName: controller
                                                              .userModel
                                                              .value
                                                              .lastName,
                                                        );
                                                      })
                                                  .then((value) => setState(() {
                                                        if (value == null) {
                                                          /// Takes care of the situation when no theme is selected.
                                                          return;
                                                        } else {
                                                          print("value $value");
                                                        }
                                                      }));
                                            },
                                            style: CustomElevatedBtnStyle(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const Icon(Icons.edit),
                                                Text("Edit",
                                                    style: GoogleFonts.getFont(
                                                        "Nunito"))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/signup');
                                            },
                                            style: CustomElevatedBtnStyle(),
                                            child: Text("Sign Out",
                                                style: GoogleFonts.getFont(
                                                    "Nunito")),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          profileimg != null
                                              ? InkWell(
                                                  onTap: () {
                                                    chooseProfilePicture();
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                        controller.userModel
                                                            .value.profileimg!,
                                                      )),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    chooseProfilePicture();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor:
                                                        Colors.grey.shade400,
                                                    child: const Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 50,
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Obx(
                                            () {
                                              return CustomText(
                                                text:
                                                    "${controller.userModel.value.firstName} ${controller.userModel.value.lastName}",
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Obx(() {
                                            return CustomText(
                                              text: controller
                                                  .userModel.value.email,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              textColor: const Color.fromARGB(
                                                  255, 167, 161, 161),
                                            );
                                          }),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          ProfileInfo()
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 45,
                                  ),
                                  Obx(() {
                                    return Expanded(
                                        flex: 3,
                                        child: SingleChildScrollView(
                                          child: pages[visibilityController
                                              .visibilityIndex.value],
                                        ));
                                  })
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Text("The error ${snapshot.error} has occured");
          } else {
            /// Returning loading screen when program needs to wait while loading the next Screen
            return const CircularProgressIndicator();
          }
        });
  }
}
