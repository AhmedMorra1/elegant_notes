import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Note Title'),
          SizedBox(
            height: 10,
          ),
          Text('Note Date'),
          SizedBox(
            height: 10,
          ),
          Text('This the first few words of the note content ')
        ],
      ),
    );
  }
}
