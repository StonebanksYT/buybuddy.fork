class SignUpModel{
  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String instituteType;
  String instituteName;
  String instituteLocation;
  SignUpModel({required this.uid,required this.firstName,required this.lastName,required this.email,required this.password,required this.confirmPassword,required this.instituteType,required this.instituteName,required this.instituteLocation});

  static SignUpModel fromMap(Map<String, dynamic> map) {
  return SignUpModel(
    uid: map['uid'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    email: map['email'],
    password: map['password'],
    confirmPassword: map['confirmPassword'],
    instituteType: map['instituteType'],
    instituteName: map['instituteName'],
    instituteLocation: map['instituteLocation'],
  );
}
}