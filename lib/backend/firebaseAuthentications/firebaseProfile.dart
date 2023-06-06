import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_auth/controllers/userIdController.dart';

class profileStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile(Uint8List? bytes, String fileName) async {
    String userid = UserIdController().userid.value;
    try {
      final path = 'profile/$userid/$fileName';
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/png',
          customMetadata: {'picked-file-path': 'profile/$userid/$fileName'});
      firebase_storage.TaskSnapshot snapshot1 =
          await storage.ref(path).putData(bytes!, metadata);
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
      });

      print('Profile picture URL saved successfully');
    } catch (e) {
      print('Error saving profile picture URL: $e');
    }
  }

  Future<String?> fetchProfileImageUrl() async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(UserIdController().userid.value);

      DatabaseEvent event = await userRef.child('profileimg').once();
      String? profileImageUrl = event.snapshot.value.toString();

      return profileImageUrl;
    } catch (e) {
      print('Error fetching profile image URL: $e');
      return null;
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


