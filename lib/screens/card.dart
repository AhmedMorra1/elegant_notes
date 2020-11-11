import 'package:flutter/material.dart';
import 'package:elegant_notes/screens/view_note.dart';
import 'package:elegant_notes/models/notemodel.dart';
import 'package:elegant_notes/size_config.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard({this.note});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return (ViewPage(
            note: note,
          ));
        }));
      },
      child: Padding(
        padding: new EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 4, bottom: SizeConfig.safeBlockHorizontal * 4),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3), color: Colors.grey.shade100),
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: new EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.toMap()['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.safeBlockVertical * 2.2, color: Colors.grey.shade700),
                  maxLines: 1,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 1,
                ),
                Text(
                  note.toMap()['datetime'].toString().substring(0, 11),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
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
