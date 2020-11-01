import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/login.dart';
import 'package:elegant_notes/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elegant_notes/screens/warning.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notes/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return (MaterialApp(
            home: Warning(
              warning: 'Error',
            ),
          ));
        }
        // once complete show your app
        if (snapshot.connectionState == ConnectionState.done) {
          print('CONNECTED');

          if (AuthService().user() == null) {
            return MaterialApp(
              home: LoginPage(),
            );
          } else {
            return MaterialApp(
              home: HomePage(),
            );
          }
        }
        // if nothing happens return loading
        return MaterialApp(
          home: //LoginPage()
              Warning(
            warning: 'Loading',
          ),
        );
      },
    );
  }
}
