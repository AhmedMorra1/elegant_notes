import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notes/screens/new_note.dart';
import 'package:elegant_notes/screens/view_note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/screens/card.dart';
import 'package:elegant_notes/models/notemodel.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static int count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('add button pressed');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NewNote();
          }));
        },
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              // Text(count != null ? count.toString() : '0'),
              NotesCount(
                auth1: auth,
              ),
              Text(auth.currentUser.uid != null ? auth.currentUser.uid : 'No user id'),
              SizedBox(
                height: 20,
              ),
              NotesGrid(
                auth1: auth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesCount extends StatelessWidget {
  final FirebaseAuth auth1;
  NotesCount({this.auth1});
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('users').doc(auth1.currentUser.uid).collection('notes');
    return StreamBuilder<QuerySnapshot>(
      stream: notes.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new Text(snapshot.data.docs.length.toString());
      },
    );
  }
}

class NotesGrid extends StatelessWidget {
  final FirebaseAuth auth1;
  NotesGrid({this.auth1});
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('users').doc(auth1.currentUser.uid).collection('notes');
    return StreamBuilder(
      stream: notes.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading events...'));
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return NoteCard(
              note: Note(
                title: snapshot.data.documents[index]['title'],
                content: snapshot.data.documents[index]['content'],
                datetime: snapshot.data.documents[index]['datetime'].toDate(),
                id: snapshot.data.documents[index].documentID,
              ),
            );
          },
          itemCount: snapshot.data.documents.length,
        );
      },
    );
  }
}
