import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';

class InsertNoteUseCase {
  final NoteRepository _repository;

  InsertNoteUseCase(this._repository);

  Future<Resource<bool>> call(NoteEntity note) {
    return _repository.insertNote(note);
  }
}
