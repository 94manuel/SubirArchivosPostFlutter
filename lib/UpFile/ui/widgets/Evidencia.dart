import 'package:file_picker_app/UpFile/repository/conexioninternet.dart';
import 'package:file_picker_app/UpFile/repository/db_api.dart';
import 'package:file_picker_app/UpFile/repository/enviardatos.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class Evidencia extends StatefulWidget {
  Evidencia({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EvidenciaState();
  }
}

class EvidenciaState extends State<Evidencia> {
  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  bool onInternet = true;
  FileType fileType;
  String base64Image;

  @override
  void saveFile(bytes, name) {
    Backendless.files
        .saveFile(bytes, filePathName: "tempfolder/$name", overwrite: true)
        .then((savedFileURL) {
      print("File saved. File URL - $savedFileURL");
    });
  }

  void _openFileExplorer() async {
    //setState(() => isLoadingPath = true);
    var estadoInternet = await conexion().con();
    setState(() => onInternet = estadoInternet);
    try {
      path = null;
      paths = await FilePicker.getMultiFilePath(
          type: fileType != null ? fileType : FileType.any,
          allowedExtensions: extensions);
      if (estadoInternet) {
        for (var i = 0; i < paths.length; i++) {
          fileName = paths.keys.toList()[i];
          final file = new File(paths.values.toList()[i]);

          //Stream<List<int>> inputStream = file.openRead();
          List<int> bytes = await file.readAsBytesSync();
          base64Image = base64Encode(bytes);

          //var _bytes = Base64Decoder().convert(base64Image);
          //print(_bytes);
          var send = await enviarDatos()
              .enviar({'NombreArchivo': fileName, 'archivo': base64Image});
        }
        /*
          Backendless.files
              .saveFile(_bytes,
                  filePathName: "tempfolder/$fileName", overwrite: true)
              .then((savedFileURL) {
            print("File saved. File URL - $savedFileURL");
          });
          
          inputStream
              .transform(utf8.decoder) // Decode bytes to UTF-8.
              .transform(
                  new LineSplitter()) // Convert stream to individual lines.
              .listen((String line) {
            // Process results.
            print('$line: ${line.length} bytes');
          }, onDone: () {
            print('File is now closed.');
          }, onError: (e) {
            print(e.toString());
          });
        */
      } else {
        for (int i = 0; i < paths.length; i++) {
          fileName = paths.keys.toList()[i];
          final file = new File(paths.values.toList()[i]);
          print(file);
          await DbArchivos.bd.newArchivos(new Archivos(
            NombreArchivo: fileName,
            archivo: file.toString(),
          ));
        }
        await AndroidAlarmManager.periodic(
            Duration(seconds: 1), 0, segundoPlano);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
    });
  }

  enviarAserver(fileName, file) async {
    var myFile = new File(file);
    print(file);
    List<int> bytes = await myFile.readAsBytesSync();
    base64Image = base64Encode(bytes);
    var send = await enviarDatos()
        .enviar({'NombreArchivo': fileName, 'archivo': base64Image});
  }

  Map<String, String> get newMethod => paths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: new RaisedButton(
                    onPressed: () => _openFileExplorer(),
                    child: new Text("Buscar Archivos"),
                  ),
                ),
                new Builder(
                  builder: (BuildContext context) => isLoadingPath
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator())
                      : path != null || paths != null
                          ? new Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: new Scrollbar(
                                  child: new ListView.separated(
                                itemCount: paths != null && paths.isNotEmpty
                                    ? paths.length
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath =
                                      paths != null && paths.isNotEmpty;
                                  final int fileNo = index + 1;
                                  final String name = 'Archivo $fileNo : ' +
                                      (isMultiPath
                                          ? paths.keys.toList()[index]
                                          : fileName ?? '...');
                                  final filePath = onInternet
                                      ? 'Archivo Subido'
                                      : 'Esperando conexion';
                                  return new ListTile(
                                    title: new Text(
                                      name,
                                    ),
                                    subtitle: new Text(filePath),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        new Divider(),
                              )),
                            )
                          : new Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
