import 'package:file_picker_app/Place/ui/screens/Servicios.dart';
import 'package:file_picker_app/UpFile/ui/screens/bottomNavigatorBar.dart';
import 'package:file_picker_app/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker_app/User/ui/screens/profile.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Inred extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.indigo), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.indigo), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.indigo), title: Text("")),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => ServiciosTrips(),
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => bottomNavigatorBar(),
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider<UserBloc>(
                      bloc: UserBloc(), child: ProfileTrips());
                },
              );
              break;
          }
        },
      ),
    );
  }
}
