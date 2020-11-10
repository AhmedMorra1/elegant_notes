import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotAlert {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;
  TextEditingController emailController = TextEditingController();
  ForgotAlert({
    @required this.context,
  });

  void showDialogNow() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password',
              style: TextStyle(
                fontSize: 18,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Please enter your email to send a password reset link to your email.',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Email here'),
                  controller: emailController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
                child: Text('Send',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                onPressed: () {
                  resetPassword(context);
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  void resetPassword(BuildContext context) async {
    if (emailController.text.trim().length == 0 || !emailController.text.trim().contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    Fluttertoast.showToast(msg: "Reset password link has sent your mail please use it to change the password.");
    Navigator.pop(context);
  }
}
