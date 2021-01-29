import 'package:file_picker/file_picker.dart';
import 'package:file_picker_app/UpFile/model/upfile.dart';
import 'package:flutter/material.dart';

class ListServices extends StatefulWidget {
  ListServices({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListServicesState();
  }
}

class ListServicesState extends State<ListServices> {
  UpFile upFile;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
