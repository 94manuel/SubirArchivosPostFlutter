import 'package:file_picker_app/User/ui/widgets/profile_place_info.dart';
import 'package:file_picker_app/widgets/floating_action_button_green.dart';
import 'package:flutter/material.dart';
import 'package:file_picker_app/Place/model/place.dart';

class Targeta extends StatelessWidget {
  Place place;

  Targeta(this.place);

  @override
  Widget build(BuildContext context) {
    final place = Text(
      this.place.name,
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 30.0, fontWeight: FontWeight.bold),
    );

    final placeInfo = Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.place.name,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                this.place.description,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )
            ]));

    final card = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      height: 220.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0))
          ]),
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[place, placeInfo],
          )),
    );

    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: <Widget>[card, FloatingActionButtonGreen()],
    );
  }
}
