import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:file_picker_app/User/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(Users user) =>
      _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);
}
