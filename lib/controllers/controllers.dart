import 'package:flutter_auth/models/productModel.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  RxString userid = "".obs;
  void setUserId(String uid) {
    userid.value = uid;
  }

  Rx<UserModel> userModel = UserModel(
          uid: "",
          address: "",
          firstName: "",
          lastName: "",
          mobileNumber: "",
          email: "",
          instituteType: "",
          instituteName: "",
          instituteLocation: "",
          profileimg: "")
      .obs;
  setUserModel(UserModel model) {
    userModel.value = model;
  }

  RxBool isObscure = true.obs;

  Rx<ProductModel> productModel =
      ProductModel(title: "", price: "", description: "", imageLink: []).obs;
  setProductModel(ProductModel model) {
    productModel.value = model;
  }

  RxString instituteType = "".obs;
  setInstituteType(String iType) {
    instituteType.value = iType;
  }

  RxString instituteName = "".obs;
  setInstituteName(String iType) {
    instituteName.value = iType;
  }

  RxString instituteLocation = "".obs;
  setInstituteLocation(String iType) {
    instituteLocation.value = iType;
  }

  RxString locationFilterValue = "Institute".obs;
  setLocationFilterValue(String value) {
    locationFilterValue.value = value;
  }

  RxString? profileimg = "".obs;
  setProfileimg(String? value) {
    profileimg!.value = value!;
  }

  RxList categoryFilterList = [].obs;
  addCategoryFilterList(String value) {
    categoryFilterList.add(value);
  }

  removeCategoryFilterlist(String value) {
    categoryFilterList.remove(value);
  }

  RxBool loginLoading = false.obs;
  setloginLoading(bool value) {
    loginLoading.value = value;
  }

  RxBool signUpLoading = false.obs;
  setsignUpLoading(bool value) {
    signUpLoading.value = value;
  }

  RxInt visibilityIndex = 0.obs;
  void setVisibility(int index) {
    visibilityIndex.value = index;
  }
}
