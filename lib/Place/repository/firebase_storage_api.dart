import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class FirebaseStorageAPI {
  firebase_storage.Reference firebaseStorageRefef =
      firebase_storage.FirebaseStorage.instance.ref();
  Future<firebase_storage.TaskSnapshot> uploadFile(
      String path, File image) async {
    try {
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRefef.child(path).putFile(image);
      return await uploadTask;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
