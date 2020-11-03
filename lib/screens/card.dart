import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/view_note.dart';
import 'package:elegant_notes/models/notemodel.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  // final String title;
  // final DateTime datetime;
  // final String content;
  NoteCard({this.note});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return (ViewPage(
            note: note,
          ));
        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Text(note.toMap()['title']),
            SizedBox(
              height: 10,
            ),
            Text(note.toMap()['datetime'].toString()),
            SizedBox(
              height: 10,
            ),
            Text(note.toMap()['content'])
          ],
        ),
      ),
    );
  }
}
