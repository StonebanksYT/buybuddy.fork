import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String instituteType;
  String instituteName;
  String instituteLocation;
  String address;
  String? profileimg;
  UserModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.email,
      required this.instituteType,
      required this.instituteName,
      required this.instituteLocation,
      this.profileimg,required this.address});
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    try {
      return UserModel(
        uid: data['uid'],
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        profileimg: data['profileimg'],
        email: data['email'] ?? '',
        address: data['address'] ?? '',
        mobileNumber: data['mobileNumber'] ?? '',
        instituteType: data['instituteType'] ?? '',
        instituteName: data['instituteName'] ?? '',
        instituteLocation: data['instituteLocation'] ?? '',


      );
    } catch (e) {
      print('Error parsing User data: $e');
      return UserModel(
        uid: '',
        profileimg: '',
        firstName: '',
        email: '',
        lastName: '',
        mobileNumber: '',
        address: '',
        instituteType: '',
        instituteName: '',
        instituteLocation: '',
      );
    }
  }
}
