class Note {
  int? id;
  String title;
  String content;
  String createdAt;
  int isPinned; // 0: false, 1: true
  int colorValue;
  String tag;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.isPinned = 0,
    this.colorValue = 0xFFFFFFFF, // Mặc định trắng
    this.tag = 'Chung',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'isPinned': isPinned,
      'colorValue': colorValue,
      'tag': tag,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: map['createdAt'],
      isPinned: map['isPinned'] ?? 0,
      colorValue: map['colorValue'] ?? 0xFFFFFFFF,
      tag: map['tag'] ?? 'Chung',
    );
  }
}
