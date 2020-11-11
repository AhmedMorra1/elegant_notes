import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:elegant_notes/size_config.dart';

class NewNote extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              //Text('Title'),
              TextField(
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                decoration: InputDecoration(
                  hintText: 'Enter title here',
                ),
                controller: titleController,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Text(
                'Content',
                style: TextStyle(color: Colors.grey),
              ),
              //Text('Content'),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.5),
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
                      padding: new EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
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
                                  fontSize: SizeConfig.blockSizeVertical * 2);
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
                                fontSize: SizeConfig.blockSizeVertical * 2);
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
                            'Cancel',
                            style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
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
