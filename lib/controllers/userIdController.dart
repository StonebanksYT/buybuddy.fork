import 'package:get/get.dart';

class UserIdController extends GetxController {
  RxString userid = "3dpJLfyKaANizuIz6KiY2sGa3IE2".obs;
  void setUserId(String uid) {
    userid.value = uid;
  }
}
