import '../../../../core/resource/resource.dart';
import '../entity/note_entity.dart';

abstract class NoteRepository {
  Future<Resource<bool>> insertNote(NoteEntity note);

  Future<Resource<List<NoteEntity>>> getNotes(String lastVisibleNote);

  Future<Resource<bool>> updateNote(NoteEntity note);

  Future<Resource<List<NoteEntity>>> searchNotes(
      String lastVisibleNote, String query);

  Future<Resource<bool>> deleteNote(String noteId);
}
