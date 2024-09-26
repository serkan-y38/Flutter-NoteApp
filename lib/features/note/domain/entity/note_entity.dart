import 'package:note_app/features/note/data/model/note_model.dart';

class NoteEntity {
  final String? id;
  final String? title;
  final String? text;
  final String? createdDate;

  NoteEntity(this.id, this.title, this.text, this.createdDate);

  NoteModel entityToModel() {
    return NoteModel(
        id: id, title: title, text: text, createdDate: createdDate);
  }
}
