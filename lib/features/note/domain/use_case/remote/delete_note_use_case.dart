import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository _repository;

  DeleteNoteUseCase(this._repository);

  Future<Resource<bool>> call(String noteId) {
    return _repository.deleteNote(noteId);
  }
}
