import 'package:get/get.dart';

class UserIdController extends GetxController {
  RxString userid="NrT25T1JVoa6FEFZjjyswV7zI5A3".obs;
  void setUserId(String uid) {
    userid.value = uid;
  }
}