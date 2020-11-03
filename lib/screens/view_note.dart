import 'package:flutter/material.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:elegant_notes/screens/edit_note.dart';

class ViewPage extends StatelessWidget {
  final Note note;
  // final String title;
  // final DateTime datetime;
  // final String content;
  ViewPage({this.note});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(note.toMap()['title']),
                RaisedButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditNote(note: note);
                    }));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(note.toMap()['datetime'].toString()),
            SizedBox(
              height: 10,
            ),
            Text(note.toMap()['content']),
          ],
        ),
      ),
    );
  }
}
