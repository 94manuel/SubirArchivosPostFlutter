import 'package:file_picker_app/UpFile/repository/enviardatos.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'dart:io';

class UpFIleBloc implements Bloc {
  final _enviarDatos = enviarDatos();
  void openFileExplorer() => _enviarDatos.openFileExplorer();
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
