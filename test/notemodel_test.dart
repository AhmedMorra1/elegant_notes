import 'package:test/test.dart';
import 'package:elegant_notes/models/notemodel.dart';

void main() {
  group('Converting a map to a model and vice versa', () {
    test('Given values should return a map of these values', () {
      DateTime timeNow = DateTime.now();
      final note = Note(title: 'Title', content: 'Content', datetime: timeNow, id: 'Document ID');
      dynamic theMap = note.toMap();
      Map<String, dynamic> actualMap = {'title': 'Title', 'content': 'Content', 'datetime': timeNow, 'id': 'Document ID'};
      expect(theMap, actualMap);
    });
    test('Given a map ov values return a note object with these values', () {
      DateTime timeNow = DateTime.now();
      Map<String, dynamic> actualMap = {'title': 'Title', 'content': 'Content', 'datetime': timeNow, 'id': 'Document ID'};
      final note = Note(title: 'Title', content: 'Content', datetime: timeNow, id: 'Document ID');
      Note theNoteObject = Note.fromMap(actualMap);
      expect(theNoteObject.id, note.id);
      expect(theNoteObject.content, note.content);
      expect(theNoteObject.datetime, note.datetime);
      expect(theNoteObject.title, note.title);
    });
  });
}
