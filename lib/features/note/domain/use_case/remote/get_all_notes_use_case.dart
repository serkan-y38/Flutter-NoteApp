import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';

class GetAllNotesUseCase {
  final NoteRepository _repository;

  GetAllNotesUseCase(this._repository);

  Future<Resource<List<NoteEntity>>> call(String lastVisibleNote) {
    return _repository.getNotes(lastVisibleNote);
  }
}
