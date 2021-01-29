import 'dart:io';
import 'package:file_picker_app/UpFile/bloc/bloc_apfile.dart';
import 'package:file_picker_app/UpFile/repository/conexioninternet.dart';
import 'package:file_picker_app/UpFile/repository/db_api.dart';
import 'package:file_picker_app/UpFile/ui/screens/servicios.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:file_picker_app/Place/ui/screens/add_place_screen.dart';
import 'circle_button.dart';
import 'package:image_picker/image_picker.dart';

class ButtonsBar extends StatelessWidget {
  UpFIleBloc upFIleBloc;
  @override
  Widget build(BuildContext context) {
    upFIleBloc = BlocProvider.of<UpFIleBloc>(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            //Cambiar la contraseña
            CircleButton(
                true,
                Icons.file_upload,
                20.0,
                Color.fromRGBO(255, 255, 255, 1),
                () => {
                      upFIleBloc.openFileExplorer(),
                    }),
            //Añadiremos un nuevo lugar
            CircleButton(
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), () {
              ImagePicker.pickImage(source: ImageSource.camera)
                  .then((File image) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddPlaceScreen(image: image)));
              }).catchError((onError) => print(onError));
            }),

            //Cerrar Sesión
            CircleButton(
                true,
                Icons.outbond,
                20.0,
                Color.fromRGBO(255, 255, 255, 1),
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Servicios()))
                    }),
          ],
        ));
  }
}

segundoPlano() async {
  var estadoInternet = await conexion().con();
  print(estadoInternet);
  if (estadoInternet) {
    var databd = await DbArchivos.bd.getDatos();
    var cantidad = int.parse(databd[1].toString());
  } else {
    var databd = await DbArchivos.bd.getDatos();
    print("datos de la bd" + databd[0].toString());
  }
}
