import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSingleton {
  static final FirebaseAuthSingleton _firebaseAuthSingleton =
      FirebaseAuthSingleton._private(auth: FirebaseAuth.instance);

  final FirebaseAuth auth;

  FirebaseAuthSingleton._private({this.auth}) {}

  factory FirebaseAuthSingleton.singleton() {
    return _firebaseAuthSingleton;
  }
}
