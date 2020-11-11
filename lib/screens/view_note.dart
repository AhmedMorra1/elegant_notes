import 'package:flutter/material.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:elegant_notes/screens/edit_note.dart';
import 'package:elegant_notes/size_config.dart';

class ViewPage extends StatelessWidget {
  final Note note;
  // final String title;
  // final DateTime datetime;
  // final String content;
  ViewPage({this.note});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: new EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, right: SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeVertical * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.blockSizeVertical * 4,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.toMap()['title'],
                          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Text(note.toMap()['datetime'].toString().substring(0, 16)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeVertical * 2,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.edit,
                      size: SizeConfig.blockSizeVertical * 4,
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
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Text(
                note.toMap()['content'],
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
