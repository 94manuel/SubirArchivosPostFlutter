import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_app/Place/model/place.dart';
import 'package:file_picker_app/User/model/user.dart';
import 'package:file_picker_app/User/ui/widgets/profile_place.dart';
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
      'urlImage': place.urlImage,
      'userOwner': _db.doc("${USERS}/${user.uid}"), //reference
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          'myPlaces':
              FieldValue.arrayUnion([_db.doc("${PLACES}/${snapshot.id}")])
        });
      });
    });
  }

  List<ProfilePlace> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, Users user) {
    List<ProfilePlace> profilePlaces = <ProfilePlace>[];
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(Place(
          name: p.data()['name'],
          description: p.data()['description'],
          urlImage: p.data()['urlImage'])));
    });

    return profilePlaces;
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = <ProfilePlace>[];
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(Place(
        name: p.data()['name'],
        description: p.data()['description'],
        urlImage: p.data()['urlImage'],
      )));
    });

    return profilePlaces;
  }
/*
  List<Place> buildPlaces(List<DocumentSnapshot> placesListSnapshot, Users user) {
    List<Place> places = List<Place>();

    placesListSnapshot.forEach((p)  {
      Place place = Place(id: p.documentID, name: p.data["name"], description: p.data["description"],
          urlImage: p.data["urlImage"],likes: p.data["likes"]
      );
      places.add(place);
    });
    return places;
  }*/

}
