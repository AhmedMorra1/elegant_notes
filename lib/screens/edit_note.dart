import 'package:flutter/material.dart';

class EditNote extends StatelessWidget {
  static String title;
  static String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Title'),
            TextField(
              onChanged: (value) {
                title = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(DateTime.now().toString()),
            SizedBox(
              height: 10,
            ),
            Text('Content'),
            TextField(
              onChanged: (value) {
                content = value;
              },
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                if (title != null) {
                  if (content != null) {
                    print('Note Saved');
                  } else {
                    print('Please add note Content.');
                  }
                } else {
                  print('Please add note Title.');
                }
                print('save note');
              },
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            RaisedButton(
                child: Text('Delete'),
                onPressed: () {
                  print('delete note');
                })
          ],
        ),
      ),
    );
  }
}
