import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_auth/controllers/userIdController.dart';

class profileStorage {
  String userid = UserIdController().userid.value;
  
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile(Uint8List? bytes, String fileName) async {
    
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
  void removeProfilePicture() async {
  final profileimg = await profileStorage().fetchProfileImageUrl();
  try {
    // Remove profile picture from storage
    if (profileimg != null && profileimg.isNotEmpty) {
      // Extract the filename from the URL
      String fileName = profileimg.split('/').last;
      final path = 'profile/$userid/$fileName';
      // Get a reference to the storage file
      firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(path);

      // Delete the file
      await storageReference.delete();
    }

    // Update profile picture URL in the database
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(UserIdController().userid.value);

    await userRef.update({
      'profileimg': '',
    });

    print('Profile picture removed successfully');
  } catch (e) {
    print('Error removing profile picture: $e');
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


