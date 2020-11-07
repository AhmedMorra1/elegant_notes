import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/view_note.dart';
import 'package:elegant_notes/models/notemodel.dart';

class NoteCard extends StatelessWidget {
  final Note note;
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
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.toMap()['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey.shade700),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  note.toMap()['datetime'].toString().substring(0, 11),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  note.toMap()['content'],
                  style: TextStyle(color: Colors.grey.shade700),
                  maxLines: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
