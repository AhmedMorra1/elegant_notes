import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notes/screens/edit_note.dart';
import 'package:elegant_notes/screens/view_note.dart';

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
            return ViewPage();
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
              Text(count != null ? count.toString() : '0'),
              Text(auth.currentUser.uid != null ? auth.currentUser.uid : 'No user id'),
            ],
          ),
        ),
      ),
    );
  }
}
