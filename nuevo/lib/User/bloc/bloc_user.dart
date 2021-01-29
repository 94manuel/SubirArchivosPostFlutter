import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:file_picker_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker_app/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<User> signIn() async => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(Users user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);
  @override
  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
