import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/card.dart';

class ViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text('Title'),
                RaisedButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    print('edit note');
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Date here'),
            SizedBox(
              height: 10,
            ),
            Text('This will be the area where the note content is shown'),
            NoteCard(),
          ],
        ),
      ),
    );
  }
}
