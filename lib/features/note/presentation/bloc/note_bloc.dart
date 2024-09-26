import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/domain/use_case/remote/delete_note_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/get_all_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/insert_note_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/domain/use_case/remote/search_note_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/update_note_use_case.dart';
import 'package:note_app/features/note/presentation/bloc/note_event.dart';
import 'package:note_app/features/note/presentation/bloc/note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final InsertNoteUseCase _insertNoteUseCase;
  final GetAllNotesUseCase _getAllNotesUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final SearchNoteUseCase _searchNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  final List<NoteEntity> _notes = List.empty(growable: true);
  final List<NoteEntity> _searchResults = List.empty(growable: true);

  NoteBloc(
    this._insertNoteUseCase,
    this._getAllNotesUseCase,
    this._updateNoteUseCase,
    this._searchNoteUseCase,
    this._deleteNoteUseCase,
  ) : super(InitialNoteState()) {
    on<InitialNoteEvent>(onInitialNoteState);
    on<InsertNoteEvent>(onInsertNote);
    on<UpdateNoteEvent>(onUpdateNote);
    on<GetInitialNotesEvent>(onGetInitialNotes);
    on<LoadMoreNotesEvent>(onLoadMoreNotes);
    on<SearchGetInitialNotesEvent>(onSearchGetInitialNotes);
    on<SearchLoadMoreNotesEvent>(onSearchLoadMoreNotes);
    on<DeleteNoteEvent>(onDeleteNote);
  }

  void onInitialNoteState(NoteEvent event, Emitter<NoteState> emitter) async {
    emitter(InitialNoteState());
  }

  void onGetInitialNotes(NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _getAllNotesUseCase.call("");
    if (state is Success<List<NoteEntity>>) {
      _notes.clear();
      _notes.addAll(state.data!);
      emitter(GetInitialNotesSuccess(_notes));
    } else if (state is Error) {
      emitter(GetNotesError(state.e!));
    } else {
      emitter(GetNotesLoading());
    }
  }

  void onLoadMoreNotes(NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _getAllNotesUseCase.call(_notes.last.createdDate!);
    if (state is Success<List<NoteEntity>>) {
      _notes.addAll(state.data!);
      emitter(LoadMoreNoteSuccess(_notes));
    } else if (state is Error) {
      emitter(GetNotesError(state.e!));
    } else {
      emitter(GetNotesLoading());
    }
  }

  void onSearchGetInitialNotes(
      NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _searchNoteUseCase.call("", event.query!);
    if (state is Success<List<NoteEntity>>) {
      _searchResults.clear();
      _searchResults.addAll(state.data!);
      emitter(SearchGetInitialNotesSuccess(_searchResults));
    } else if (state is Error) {
      emitter(SearchGetNotesError(state.e!));
    } else {
      emitter(SearchGetNotesLoading());
    }
  }

  void onSearchLoadMoreNotes(
      NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _searchNoteUseCase.call(
        _searchResults.last.createdDate!, event.query!);
    if (state is Success<List<NoteEntity>>) {
      _searchResults.addAll(state.data!);
      emitter(SearchLoadMoreNoteSuccess(_searchResults));
    } else if (state is Error) {
      emitter(SearchGetNotesError(state.e!));
    } else {
      emitter(SearchGetNotesLoading());
    }
  }

  void onInsertNote(NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _insertNoteUseCase.call(event.note!);
    if (state is Success<bool>) {
      emitter(InsertNoteSuccess());
    } else if (state is Error) {
      emitter(InsertNoteError(state.e!));
    } else {
      emitter(InsertNoteLoading());
    }
  }

  void onUpdateNote(NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _updateNoteUseCase.call(event.note!);
    if (state is Success<bool>) {
      emitter(UpdateNoteSuccess());
    } else if (state is Error) {
      emitter(UpdateNoteError(state.e!));
    } else {
      emitter(UpdateNoteLoading());
    }
  }

  void onDeleteNote(NoteEvent event, Emitter<NoteState> emitter) async {
    final state = await _deleteNoteUseCase.call(event.noteId!);
    if (state is Success<bool>) {
      emitter(DeleteNoteSuccess());
    } else if (state is Error) {
      emitter(DeleteNoteError(state.e!));
    } else {
      emitter(DeleteNoteLoading());
    }
  }
}
