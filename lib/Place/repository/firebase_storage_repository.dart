import 'dart:io';
import 'package:file_picker_app/Place/repository/firebase_storage_api.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageRepository {
  final _firebaseStorageAPI = FirebaseStorageAPI();
  Future<firebase_storage.TaskSnapshot> uploadFile(String path, File image) =>
      _firebaseStorageAPI.uploadFile(path, image);
}
