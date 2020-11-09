import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Alert {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String title;
  final String message;
  final String button;
  final String button2;
  final BuildContext context;

  Alert({@required this.title, @required this.message, @required this.button, @required this.context, @required this.button2});

  void showDialogNow() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(
                fontSize: 18,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                button,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
                child: Text(button2,
                    style: TextStyle(
                      fontSize: 18,
                    )),
                onPressed: () async {
                  await auth.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                })
          ],
        );
      },
    );
  }
}
