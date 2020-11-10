import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewNote extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                height: 20,
              ),
              //Text('Title'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter title here',
                ),
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              //Text('Content'),
              Expanded(
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Note content here',
                  ),
                  controller: contentController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          print('this title is');
                          print(titleController.text.trim());
                          if (titleController.text.trim().length != 0) {
                            if (contentController.text.trim().length != 0) {
                              print('Note Saved');
                              addNote(Note(title: titleController.text.trim(), content: contentController.text, datetime: DateTime.now()).toMap());
                              Navigator.of(context).pop();
                            } else {
                              print('Please add note Content.');
                              Fluttertoast.showToast(
                                  msg: "Please add note Content.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            print('Please add note Title.');
                            Fluttertoast.showToast(
                                msg: "Please add note Title.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          print('save note');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: RaisedButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            print('Cancel note');
                            Navigator.of(context).pop();
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

  Future<void> addNote(Map data) {
    return users.doc(auth.currentUser.uid).collection('notes').add(data).then((value) => print("Note Added")).catchError((error) => print("Failed to add Note: $error"));
  }
}
