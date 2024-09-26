import 'package:note_app/features/note/domain/entity/note_entity.dart';

class NoteEvent {
  NoteEntity? note;
  String? query;
  String? noteId;

  NoteEvent({this.note, this.query, this.noteId});
}

class InitialNoteEvent extends NoteEvent {
  InitialNoteEvent();
}

class InsertNoteEvent extends NoteEvent {
  InsertNoteEvent(NoteEntity e) : super(note: e);
}

class UpdateNoteEvent extends NoteEvent {
  UpdateNoteEvent(NoteEntity e) : super(note: e);
}

class GetInitialNotesEvent extends NoteEvent {
  GetInitialNotesEvent();
}

class LoadMoreNotesEvent extends NoteEvent {
  LoadMoreNotesEvent();
}

class SearchGetInitialNotesEvent extends NoteEvent {
  SearchGetInitialNotesEvent(String query) : super(query: query);
}

class SearchLoadMoreNotesEvent extends NoteEvent {
  SearchLoadMoreNotesEvent(String query) : super(query: query);
}

class DeleteNoteEvent extends NoteEvent {
  DeleteNoteEvent(String noteId) : super(noteId: noteId);
}
