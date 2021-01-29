import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(Users user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'photoURL': user.photoURL,
      'chores': user.chores,
      'email': user.email,
      'photos': user.photos,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    User user = _auth.currentUser;
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'userOwner': "${USERS}/${user.uid}", //reference
    });
  }
}
