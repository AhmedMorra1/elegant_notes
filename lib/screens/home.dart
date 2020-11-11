import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notes/screens/new_note.dart';
import 'package:elegant_notes/screens/logout_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notes/screens/card.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:flutter/rendering.dart';
import 'package:elegant_notes/size_config.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static int count;
  final String uid;
  HomePage({this.uid});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print('Current user is $uid');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: SizeConfig.safeBlockVertical * 5,
        ),
        onPressed: () {
          print('add button pressed');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NewNote();
          }));
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: new EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: new EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 4, fontWeight: FontWeight.bold),
                            ),
                            NotesCount(
                              auth1: auth,
                              uid: uid,
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Icon(Icons.logout),
                          onTap: () {
                            LogoutAlert(
                              context: context,
                            ).showDialogNow();
                            // await auth.signOut();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            //   return LoginPage();
                            // }));
                          },
                        )
                      ],
                    ),
                  ),
                  // Text(count != null ? count.toString() : '0'),

                  //Text(auth.currentUser != null ? auth.currentUser.uid : 'Loading...'),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: new EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 4),
                    child: NotesGrid(
                      auth1: auth,
                      uid: uid,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotesCount extends StatelessWidget {
  final FirebaseAuth auth1;
  final String uid;
  NotesCount({this.auth1, this.uid});
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('users').doc(auth1.currentUser != null ? auth1.currentUser.uid : 'Loading...').collection('notes');
    return StreamBuilder<QuerySnapshot>(
      stream: notes.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new Text(
          '${snapshot.data.docs.length.toString()} notes',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockVertical * 2,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

class NotesGrid extends StatelessWidget {
  final FirebaseAuth auth1;
  final String uid;
  NotesGrid({this.auth1, this.uid});
  @override
  Widget build(BuildContext context) {
    Query notes = FirebaseFirestore.instance.collection('users').doc(auth1.currentUser != null ? auth1.currentUser.uid : 'Loading...').collection('notes').orderBy('datetime', descending: true);
    return StreamBuilder(
      stream: notes.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading events...'));
        }
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        print('SSSSSSSSSNNNNNNNNNNAAAAAAAAAAPPPPPPPPPPPP');
        print(snapshot.data.documents);
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
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
