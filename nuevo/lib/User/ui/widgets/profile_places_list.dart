import 'package:flutter/material.dart';
import 'package:file_picker_app/User/ui/widgets/profile_place.dart';
import 'package:file_picker_app/Place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  Place place = new Place(
      name: 'Mountains',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage: 'Scenery & Photography',
      userOwner: null);
  Place place2 = new Place(
      name: 'Mountains',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage: 'Scenery & Photography',
      userOwner: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),
    );
  }
}
