import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UpFile {
  String path;
  List<String> extensions;
  Map<String, String> paths;
  FileType fileType;
  String fileName;
  String base64Image;

  UpFile(
      {Key key,
      @required this.path,
      @required this.paths,
      @required this.fileType,
      @required this.base64Image,
      this.fileName,
      this.extensions});
}
