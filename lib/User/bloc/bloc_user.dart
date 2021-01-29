import 'dart:async';

import 'package:backendless_sdk/backendless_sdk.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/Place/repository/firebase_storage_repository.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:file_picker_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker_app/User/repository/cloud_firestore_api.dart';
import 'package:file_picker_app/User/repository/cloud_firestore_repository.dart';
import 'package:file_picker_app/User/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  get currentUser => FirebaseAuth.instance.currentUser;

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<User> signIn() async => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(Users user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);
  List<ProfilePlace> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, Users user) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot, user);

  Stream<QuerySnapshot> myPlacesListSream(String uid) =>
      FirebaseFirestore.instance
          .collection(CloudFirestoreAPI().PLACES)
          .where("userOwner",
              isEqualTo: FirebaseFirestore.instance
                  .doc("${CloudFirestoreAPI().USERS}/${uid}"))
          .snapshots();
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  StreamController<Place> placeSelectedStreamController =
      StreamController<Place>();
  Stream<Place> get placeSelectedStream => placeSelectedStreamController.stream;
  StreamSink<Place> get placeSelectedSink => placeSelectedStreamController.sink;

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<firebase_storage.TaskSnapshot> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);
  @override
  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
