import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/models/notemodel.dart';

class NewNote extends StatelessWidget {
  static String title;
  static String content;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Title'),
            TextField(
              onChanged: (value) {
                title = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(DateTime.now().toString()),
            SizedBox(
              height: 10,
            ),
            Text('Content'),
            TextField(
              onChanged: (value) {
                content = value;
              },
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                if (title != null) {
                  if (content != null) {
                    print('Note Saved');
                    addNote(Note(title: title, content: content, datetime: DateTime.now()).toMap());
                    Navigator.of(context).pop();
                  } else {
                    print('Please add note Content.');
                  }
                } else {
                  print('Please add note Title.');
                }
                print('save note');
              },
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            RaisedButton(
                child: Text('Cancel'),
                onPressed: () {
                  print('Cancel note');
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }

  Future<void> addNote(Map data) {
    return users.doc(auth.currentUser.uid).collection('notes').add(data).then((value) => print("Note Added")).catchError((error) => print("Failed to add Note: $error"));
  }
}
