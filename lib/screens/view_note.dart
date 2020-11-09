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
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.toMap()['title'],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(note.toMap()['datetime'].toString().substring(0, 16)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return EditNote(note: note);
                      }));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                note.toMap()['content'],
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
