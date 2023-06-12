import 'package:get/get.dart';

class UserIdController extends GetxController {
  RxString userid = "WTzyKXfe3mTclFpuJKJ5fMRBZJn2".obs;
  void setUserId(String uid) {
    userid.value = uid;
  }
}
