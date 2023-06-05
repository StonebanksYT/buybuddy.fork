import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_auth/controllers/userIdController.dart';

class profileStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<String> uploadFile(Uint8List? bytes, String fileName) async {
    try {
      firebase_storage.TaskSnapshot snapshot1 =
          await storage.ref("profile/$fileName").putData(bytes!);
      String downloadUrl = await snapshot1.ref.getDownloadURL();
      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      print('Error uploading profile picture: $e');
      return '';
    }
  }

  void saveProfilePictureUrl(String profilePictureUrl) async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(UserIdController().userid.value);
      
      await userRef.update({
        'profileimg': profilePictureUrl,
      }
      );

      print('Profile picture URL saved successfully');
    } catch (e) {
      print('Error saving profile picture URL: $e');
    }
  }
}

// Future<String> uploadProfilePicture(File imageFile) async {
//   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//   Reference storageReference = FirebaseStorage.instance
//       .ref()
//       .child('profile_pictures/$fileName');

//   try {
//     TaskSnapshot snapshot = await storageReference.putFile(imageFile);
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   } catch (e) {
//     print('Error uploading profile picture: $e');
//     return '';
//   }
// }


