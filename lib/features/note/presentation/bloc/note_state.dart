import 'package:note_app/features/note/domain/entity/note_entity.dart';

abstract class NoteState {
  Exception? e;
  List<NoteEntity>? notes;
  List<NoteEntity>? searchResult;

  NoteState({this.e, this.notes, this.searchResult});
}

class InitialNoteState extends NoteState {
  InitialNoteState();
}

/*
* get notes - load more notes
*/

class GetInitialNotesSuccess extends NoteState {
  GetInitialNotesSuccess(List<NoteEntity> notes) : super(notes: notes);
}

class LoadMoreNoteSuccess extends NoteState {
  LoadMoreNoteSuccess(List<NoteEntity> notes) : super(notes: notes);
}

class GetNotesError extends NoteState {
  GetNotesError(Exception e) : super(e: e);
}

class GetNotesLoading extends NoteState {
  GetNotesLoading();
}

/*
* search (get notes - load more) notes
*/

class SearchGetInitialNotesSuccess extends NoteState {
  SearchGetInitialNotesSuccess(List<NoteEntity> searchResult)
      : super(searchResult: searchResult);
}

class SearchLoadMoreNoteSuccess extends NoteState {
  SearchLoadMoreNoteSuccess(List<NoteEntity> searchResult)
      : super(searchResult: searchResult);
}

class SearchGetNotesError extends NoteState {
  SearchGetNotesError(Exception e) : super(e: e);
}

class SearchGetNotesLoading extends NoteState {
  SearchGetNotesLoading();
}

/*
* insert note
*/

class InsertNoteSuccess extends NoteState {
  InsertNoteSuccess();
}

class InsertNoteError extends NoteState {
  InsertNoteError(Exception e) : super(e: e);
}

class InsertNoteLoading extends NoteState {
  InsertNoteLoading();
}

/*
* update note
*/

class UpdateNoteSuccess extends NoteState {
  UpdateNoteSuccess();
}

class UpdateNoteError extends NoteState {
  UpdateNoteError(Exception e) : super(e: e);
}

class UpdateNoteLoading extends NoteState {
  UpdateNoteLoading();
}

/*
* delete note
*/

class DeleteNoteSuccess extends NoteState {
  DeleteNoteSuccess();
}

class DeleteNoteError extends NoteState {
  DeleteNoteError(Exception e) : super(e: e);
}

class DeleteNoteLoading extends NoteState {
  DeleteNoteLoading();
}
