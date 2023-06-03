import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadFile(Uint8List? bytes, String fileName) async {
    try {
      await storage.ref("tests/$fileName").putData(bytes!);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
