import 'package:get/get.dart';

class UserIdController extends GetxController {
  RxString userid = "us3aSXEaeUMtaWb2E3PRdw54bom1".obs;
  void setUserId(String uid) {
    userid.value = uid;
  }
}
