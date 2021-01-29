import 'package:file_picker_app/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async {
    try {
      print("conectando");
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      UserCredential result = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: gSA.idToken, accessToken: gSA.accessToken));
      User user = await result.user;
      print("conectado");
      return user;
    } catch (e) {
      print("No conecto");
      print(e);
    }
  }

  signOut() async {
    await _auth.signOut().then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut();
    print("Sesiones cerradas");
  }
}
