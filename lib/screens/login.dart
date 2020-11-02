import 'package:elegant_notes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  static String email;
  static String password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Email'),
            TextField(
              onChanged: (value) {
                email = value;
              },
            ),
            Text('Password'),
            TextField(
              onChanged: (value) {
                password = value;
              },
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                print('Login button pressed');
                _signInWithEmailAndPassword(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
            ),
            RaisedButton(
              child: Text('Sign Up'),
              onPressed: () {
                print('Sign Up button pressed');
                _register();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Example code for registration.
  void _register() async {
    final User user = (await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      print('SIGN UP SUCCESS');
    } else {
      print('SING UP FAILURE');
    }
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final User user = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print('Signed In');
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Failed with error code: ${e.code}')));
    }
  }
}
