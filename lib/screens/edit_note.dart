import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:elegant_notes/screens/home.dart';

class EditNote extends StatelessWidget {
  final Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  EditNote({this.note});
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    contentController.text = note.content;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Title'),
            TextField(
              controller: titleController,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Content'),
            TextField(
              controller: contentController,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                if (titleController.text != null) {
                  if (contentController.text != null) {
                    print('Note Saved');
                    updateNote(Note(title: titleController.text, content: contentController.text, datetime: DateTime.now()).toMap());
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
                child: Text('Delete'),
                onPressed: () {
                  print('delete note');
                  deleteNote();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }

  Future<void> updateNote(Map data) {
    return users.doc(auth.currentUser.uid).collection('notes').doc(note.id).update(data).then((value) => print("Note Added")).catchError((error) => print("Failed to add Note: $error"));
  }

  Future<void> deleteNote() {
    return users.doc(auth.currentUser.uid).collection('notes').doc(note.id).delete().then((value) => print("Note Deleted")).catchError((error) => print("Failed to delete Note: $error"));
  }
}
