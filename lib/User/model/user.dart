import 'package:file_picker_app/Place/model/place.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place> photos;
  final List<Place> chores;

  //myFavoritePlaces
  //myPlaces

  Users(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      this.photos,
      this.chores});
}
