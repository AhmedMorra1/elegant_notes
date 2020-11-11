import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:elegant_notes/screens/delete_alert.dart';
import 'package:elegant_notes/size_config.dart';

class EditNote extends StatelessWidget {
  final Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  EditNote({this.note});
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    titleController.text = note.title;
    contentController.text = note.content;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: new EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Text(
                'Title',
                style: TextStyle(color: Colors.grey),
              ),
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                maxLines: null,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Text(
                'Content',
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: TextField(
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: contentController,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: new EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: new EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                      child: RaisedButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                          onPressed: () {
                            print('delete note');
                            DeleteAlert(context: context, noteId: note.id).showDialogNow();
                            // deleteNote();
                            // Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                          }),
                    ),
                  )
                ],
              ),
            ],
          ),
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
