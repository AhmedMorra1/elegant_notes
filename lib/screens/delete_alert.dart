import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/size_config.dart';

class DeleteAlert {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String noteId;
  final BuildContext context;

  DeleteAlert({@required this.context, @required this.noteId});

  void showDialogNow() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Note',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 2.5,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Do you confirm deleting this note?',
                  style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'No',
                style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
                child: Text('Yes',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                    )),
                onPressed: () async {
                  await deleteNote();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  Future<void> deleteNote() {
    return users.doc(auth.currentUser.uid).collection('notes').doc(noteId).delete().then((value) => print("Note Deleted")).catchError((error) => print("Failed to delete Note: $error"));
  }
}
