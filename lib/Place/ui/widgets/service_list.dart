import 'package:file_picker_app/Place/ui/widgets/targeta.dart';
import 'package:file_picker_app/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ServiciosList extends StatelessWidget {
  UserBloc userBloc;
  /*
  Place place = new Place(
      name: 'Servicio 1',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage: 'Scenery & Photography',
      userOwner: null);
  Place place2 = new Place(
      name: 'Servicio 2',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage: 'Scenery & Photography',
      userOwner: null);

  Place place3 = new Place(
      name: 'Servicio 3',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage: 'Scenery & Photography',
      userOwner: null);*/

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.placesStream,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot != null && snapshot.hasError) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                            children:
                                userBloc.buildMyPlaces(snapshot.data.doc)),
                      )
                    ],
                  );
                case ConnectionState.active:
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                            children:
                                userBloc.buildMyPlaces(snapshot.data.doc)),
                      )
                    ],
                  );

                case ConnectionState.none:
                  return CircularProgressIndicator();
                default:
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                            children:
                                userBloc.buildMyPlaces(snapshot.data.docs)),
                      )
                    ],
                  );
              }
            } else {}
          }),
    );
  }
}
