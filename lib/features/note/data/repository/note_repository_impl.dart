import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/data/sources/remote/note_source.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteSource _source;

  NoteRepositoryImpl(this._source);

  @override
  Future<Resource<bool>> insertNote(NoteEntity note) {
    return _source.insertNote(note.entityToModel());
  }

  @override
  Future<Resource<List<NoteEntity>>> getNotes(String lastVisibleNote) {
    return _source.getNotes(lastVisibleNote);
  }

  @override
  Future<Resource<bool>> updateNote(NoteEntity note) {
    return _source.updateNote(note.entityToModel());
  }

  @override
  Future<Resource<List<NoteEntity>>> searchNotes(
      String lastVisibleNote, String query) {
    return _source.searchNotes(lastVisibleNote, query);
  }

  @override
  Future<Resource<bool>> deleteNote(String noteId) {
    return _source.deleteNote(noteId);
  }
}
