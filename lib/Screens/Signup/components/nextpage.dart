import 'package:flutter/material.dart';
import 'package:flutter_auth/backend/firebaseAuthentications/firebaseSignup.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:flutter_auth/Screens/utils/loginSignUpAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_auth/controllers/userIdController.dart';

Color textFilledColor = const Color(0xfff1f1f1);

class FieldStyle extends StatefulWidget {
  final String fieldName;
  final Function(String) onChanged;
  TextEditingController controller;
  FieldStyle(
      {Key? key,
      required this.fieldName,
      required this.controller,
      required this.onChanged,
      })
      : super(key: key);

  @override
  State<FieldStyle> createState() => _FieldStyleState();
}

class _FieldStyleState extends State<FieldStyle> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.controller = TextEditingController(text: widget.);
  //   setState(() {
  //     print("fieldstyle ${widget.controller.text}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          width: 410,
          child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              obscureText: false,
              keyboardType: TextInputType.name,
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 7, left: 10),
                filled: true,
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
              )),
        ),
      ],
    );
  }
}

class NextPageOfSignUpPage extends StatefulWidget {
  // fetching user credentials from sign up body
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String emailAddress;
  final String password;
  const NextPageOfSignUpPage(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.emailAddress,
      required this.password})
      : super(key: key);
  @override
  State<NextPageOfSignUpPage> createState() => _NextPageOfSignUpPageState();
}

class _NextPageOfSignUpPageState extends State<NextPageOfSignUpPage> {
  var instituteNameController = TextEditingController();
  var instituteLocationController = TextEditingController();
  Controller controller = Get.put(Controller());
  UserIdController userIdController = Get.put(UserIdController());
  Widget _buildSchoolDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       FieldStyle(
          fieldName: "School Name",
          onChanged: (p0) {
            controller.setInstituteName(p0);
            print("name ${controller.instituteName.value}");
          },
          controller: instituteNameController,
        )
,        const SizedBox(height: 20),
       FieldStyle(
          fieldName: "School Address",
          onChanged: (p0) {
            controller.setInstituteLocation(p0);
            print("location ${controller.instituteLocation.value}");
          },
          controller: instituteLocationController,
        )
      ],
    );
  }

  Widget _buildCollegeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       FieldStyle(
          fieldName: "College Name",
          onChanged: (p0) {
            controller.setInstituteName(p0);
            print("name ${controller.instituteName.value}");

          },
          controller: instituteNameController,
          
        )
,        const SizedBox(height: 20),
       FieldStyle(
            fieldName: "College Address",
            onChanged: (p0) {
              controller.setInstituteLocation(p0);
            print("location ${controller.instituteLocation.value}");

            },
            controller: instituteLocationController,
            )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          LoginSignUpAppBar(isLogin: false),
          Row(
            children: [
              Container(
                color: Colors.amber,
                width: size.width * 0.4,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Center(
                  child: SizedBox(
                    width: 450,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Are you from School or College?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(children: [
                            Row(
                              children: [
                                Obx(
                                  () {
                                    return Radio(
                                      value: 'school',
                                      groupValue:
                                          controller.instituteType.value,
                                      onChanged: (value) {
                                        controller
                                            .setInstituteType(value as String);
                                        print(controller.instituteType.value);
                                      },
                                    );
                                  },
                                ),
                                const Text(
                                  'School',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Radio(
                                    value: 'college',
                                    groupValue: controller.instituteType.value,
                                    onChanged: (value) {
                                      controller
                                          .setInstituteType(value as String);
                                      print(controller.instituteType.value);
                                    },
                                  );
                                }),
                                const Text(
                                  'College',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ]),
                          const SizedBox(height: 20),
                          Obx(
                            () {
                              return controller.instituteType.value == 'school'
                                  ? _buildSchoolDetails()
                                  : controller.instituteType.value == 'college'
                                      ? _buildCollegeDetails()
                                      : const SizedBox();
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Color(0xff002aff),
                                              width: 2)),
                                      padding: const EdgeInsets.all(8),
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.white),
                                  child: const Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var instituteName =
                                        controller.instituteName.value.trim();
                                    var instituteLocation = controller
                                        .instituteLocation.value
                                        .trim();
                                    if (controller
                                            .instituteType.value.isEmpty ||
                                        instituteName.isEmpty ||
                                        instituteLocation.isEmpty) {
                                      // show error toast
                                      Fluttertoast.showToast(
                                          msg: 'Please fill all fields');
                                      return;
                                    }
                                    controller.setsignUpLoading(true);
                                    await FirebaseSignUp(
                                            context: context,
                                            emailAddress: widget.emailAddress,
                                            firstName: widget.firstName,
                                            instituteLocation:
                                                instituteLocation,
                                            instituteName: instituteName,
                                            instituteType:
                                                controller.instituteType.value,
                                            lastName: widget.lastName,
                                            mobileNumber: widget.mobileNumber,
                                            password: widget.password,
                                            userIdController: userIdController)
                                        .firebaseSignUp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Color(0xff002aff),
                                              width: 2)),
                                      padding: const EdgeInsets.all(8),
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.white),
                                  child: controller.signUpLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          "Create Account",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
