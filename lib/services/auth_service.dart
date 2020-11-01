import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  User user() {
    // ignore: deprecated_member_use
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        return null;
      } else {
        return user;
      }
    });
  }
}
