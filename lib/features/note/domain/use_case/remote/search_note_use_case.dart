import 'package:note_app/features/note/domain/repository/note_repository.dart';
import '../../../../../core/resource/resource.dart';
import '../../entity/note_entity.dart';

class SearchNoteUseCase {
  final NoteRepository _repository;

  SearchNoteUseCase(this._repository);

  Future<Resource<List<NoteEntity>>> call(
      String lastVisibleNote, String query) {
    return _repository.searchNotes(lastVisibleNote, query);
  }
}
