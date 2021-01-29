import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageAPI {
  final firebase_storage.Reference _storageReference =
      firebase_storage.FirebaseStorage.instance.ref();

  Future<firebase_storage.TaskSnapshot> uploadFile(
      String path, File image) async {
    return _storageReference.child(path).putFile(image);
  }
}
