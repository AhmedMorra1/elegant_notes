import 'dart:ui';

import 'package:elegant_notes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  static String email;
  static String password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  static String uid;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Email'),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                maxLines: 1,
                autofocus: false,
                showCursor: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(2))),
                ),
                textAlign: TextAlign.start,
              ),
              //Text('Password'),
              SizedBox(
                height: 30,
              ),
              Text('Password'),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                maxLines: 1,
                autofocus: false,
                showCursor: true,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(2))),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: RaisedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        print('Login button pressed');
                        _signInWithEmailAndPassword(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return HomePage(
                            uid: uid,
                          );
                        }));
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(child: Text('Or')),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: RaisedButton(
                      highlightColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        print('Sign Up button pressed');
                        _register();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example code for registration.
  void _register() async {
    final User user = (await auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
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
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      print('Signed In');
      uid = auth.currentUser.uid;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Failed with error code: ${e.code}')));
    }
  }
}
