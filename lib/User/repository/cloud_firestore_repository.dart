import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:file_picker_app/User/repository/cloud_firestore_api.dart';
import 'package:file_picker_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(Users user) =>
      _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
  List<ProfilePlace> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, Users user) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot, user);
}
