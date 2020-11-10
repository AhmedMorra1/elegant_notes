import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutAlert {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;

  LogoutAlert({@required this.context});

  void showDialogNow() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out!',
              style: TextStyle(
                fontSize: 18,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Do you confirm signing out?',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'No',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
                child: Text('Yes',
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
