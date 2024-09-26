import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository _repository;

  UpdateNoteUseCase(this._repository);

  Future<Resource<bool>> call(NoteEntity note) {
    return _repository.updateNote(note);
  }
}
