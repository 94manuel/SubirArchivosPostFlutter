import 'package:file_picker_app/Place/ui/screens/Servicios_header.dart';
import 'package:file_picker_app/Place/ui/widgets/service_list.dart';
import 'package:flutter/material.dart';
import 'package:file_picker_app/User/ui/widgets/profile_background.dart';

class ServiciosTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/
    return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[ServiciosList()],
        ),
      ],
    );
  }
}
