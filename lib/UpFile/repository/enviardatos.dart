import 'dart:convert';
import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_app/UpFile/repository/conexioninternet.dart';
import 'package:file_picker_app/UpFile/repository/db_api.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class enviarDatos {
  String path;
  List<String> extensions;
  Map<String, String> paths;
  FileType fileType;
  String fileName;
  bool onInternet = true;
  String base64Image;
  bool isLoadingPath = false;

  enviar(data) async {
    try {
      var url = 'http://192.168.10.173';
      final http.Response response = await http.post(url, body: data);
      //print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        //print(jsonDecode(response.body));
        return true;
      } else {
        throw Exception('Error al enviar informacion');
      }
    } on SocketException catch (_) {
      print('error en la conexion');
      return false;
    }
  }

  void openFileExplorer() async {
    //setState(() => isLoadingPath = true);
    var estadoInternet = await conexion().con();
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
  }

  void segundoPlano() async {
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

  void enviarAserver(fileName, file) async {
    var myFile = new File(file);
    print(file);
    List<int> bytes = await myFile.readAsBytesSync();
    base64Image = base64Encode(bytes);
    var send = await enviarDatos()
        .enviar({'NombreArchivo': fileName, 'archivo': base64Image});
  }

  void saveFile(bytes, name) {
    Backendless.files
        .saveFile(bytes, filePathName: "tempfolder/$name", overwrite: true)
        .then((savedFileURL) {
      print("File saved. File URL - $savedFileURL");
    });
  }
}
