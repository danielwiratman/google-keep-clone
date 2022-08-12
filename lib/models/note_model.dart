class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime createdTime;
  final String color;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdTime,
    required this.color,
  });

  Map<String, Object?> toMap() => {
        '_id': id,
        'title': title,
        'content': content,
        'createdTime': createdTime.toIso8601String(),
        'color': color
      };

  static NoteModel fromMap(Map<String, Object?> map) => NoteModel(
      id: map['_id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      createdTime: DateTime.parse(map['createdTime'] as String),
      color: map['color'] as String);
}
