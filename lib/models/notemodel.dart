class Note {
  String title;
  String content;
  DateTime datetime;
  String id;

  Note({this.content, this.datetime, this.title, this.id});

  //Convert to Map
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'datetime': datetime, 'id': id};
  }

  //Read from Map
  Note.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    content = data['content'];
    datetime = data['datetime'];
    id = data['id'];
  }
}
