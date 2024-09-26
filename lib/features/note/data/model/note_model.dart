import 'package:note_app/features/note/domain/entity/note_entity.dart';

class NoteModel {
  final String? id;
  final String? title;
  final String? text;
  final String? createdDate;

  NoteModel({this.id, this.title, this.text, this.createdDate});

  NoteEntity modelToEntity() {
    return NoteEntity(
      id,
      title,
      text,
      createdDate
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id!,
      'title': title!,
      'text': text!,
      'created_date': createdDate!
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      text: json['text'] ?? "",
      createdDate: json['created_date'] ?? "",
    );
  }
}
