import 'package:flutter_auth/models/productModel.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  RxBool isFirebaseInitialized=false.obs;
  setIsFirebaseInitalized(bool value){
    isFirebaseInitialized.value=value;
  }
  Rx<UserModel> userModel = UserModel(
          firstName: "",
          lastName: "",
          mobileNumber: "",
          email: "",
          instituteType: "",
          instituteName: "",
          instituteLocation: "")
      .obs;
  setUserModel(UserModel model) {
    userModel.value = model;
  }

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

  RxBool canResendEmail = false.obs;
  setCanResendEmail(bool value) {
    canResendEmail.value = value;
  }
  RxBool isEmailVerified=false.obs;
  setisEmailVerified(bool value){
    isEmailVerified.value=value;
  }
}
