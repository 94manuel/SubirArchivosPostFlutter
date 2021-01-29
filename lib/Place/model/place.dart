import 'package:flutter/material.dart';
import 'package:file_picker_app/User/model/user.dart';

class Place {
  String id;
  String name;
  String description;
  String urlImage;
  Users userOwner;

  Place(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.urlImage,
      @required this.userOwner});
}
