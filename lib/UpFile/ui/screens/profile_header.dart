import 'package:file_picker_app/UpFile/bloc/bloc_apfile.dart';
import 'package:file_picker_app/UpFile/ui/screens/list.dart';
import 'package:file_picker_app/UpFile/ui/widgets/button_bar.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return showProfileData();
  }

  Widget showProfileData() {
    return BlocProvider(
        child: MaterialApp(
          home: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            child: Column(
              children: <Widget>[ButtonsBar(), ListServices()],
            ),
          ),
        ),
        bloc: UpFIleBloc());
  }
}
