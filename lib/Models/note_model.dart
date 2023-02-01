class Note {
  String noteTitle, note;
  int? id;

  Note({required this.noteTitle, required this.note, this.id});

  Map<String, dynamic> toJson() => {'id': id, 'noteTitle': noteTitle, 'note': note};

  static Note fromJson(Map<String, dynamic> json) => Note(id: json['id'], noteTitle: json['noteTitle']!, note: json['note']!);

}
