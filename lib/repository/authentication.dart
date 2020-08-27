import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';

class Authentification {
  Future<UserCredential> signGoogle() async {
    try {
      // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final firebaseAuth = FirebaseAuthSingleton.singleton();
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await firebaseAuth.auth.signInWithCredential(credential);

      return authResult;
    } catch (e) {
      throw Exception(e);
    }
  }
}
