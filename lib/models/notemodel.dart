class Note {
  String title;
  String content;
  DateTime datetime;

  Note({this.content, this.datetime, this.title});

  //Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'datetime': datetime,
    };
  }

  //Read from Map
  Note.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    content = data['content'];
    datetime = data['datetime'];
  }

  //Update
  //Delete
}
