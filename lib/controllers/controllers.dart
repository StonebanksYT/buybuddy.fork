import 'package:flutter_auth/models/productModel.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  Rx<UserModel> userModel=UserModel(firstName: "", lastName: "",mobileNumber: "", email: "", instituteType: "", instituteName: "", instituteLocation: "").obs;
  setUserModel(UserModel model){
    userModel.value=model;
  }
  Rx<ProductModel> productModel=ProductModel(title: "", price: "", description:"" , imageLink: []).obs;
  setProductModel(ProductModel model){
    productModel.value=model;
  }
  RxString instituteType="".obs;
  setInstituteType(String iType){
    instituteType.value=iType;
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
}