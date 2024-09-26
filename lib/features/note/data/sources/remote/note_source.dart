import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/note/data/model/note_model.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';

class NoteSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;

  NoteSource(this._auth, this._firebaseFirestore);

  Future<Resource<List<NoteEntity>>> getNotes(String lastVisibleNote) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("all_notes")
          .collection("notes")
          .orderBy('created_date')
          .startAfter([lastVisibleNote])
          .limit(12)
          .get();

      final notes = List<NoteEntity>.from(querySnapshot.docs
          .map((el) => NoteModel.fromJson(el.data()).modelToEntity()));

      return Success(notes);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<List<NoteEntity>>> searchNotes(
    String lastVisibleNote,
    String query,
  ) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("all_notes")
          .collection("notes")
          .orderBy('created_date')
          .startAfter([lastVisibleNote])
          .where('title', isEqualTo: query, isGreaterThan: query)
          .where('text', isEqualTo: query, isGreaterThan: query)
          .limit(12)
          .get();

      final notes = List<NoteEntity>.from(querySnapshot.docs
          .map((el) => NoteModel.fromJson(el.data()).modelToEntity()));

      return Success(notes);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> insertNote(NoteModel noteModel) async {
    try {
      Loading;

      var model = NoteModel(
        id: _firebaseFirestore
            .collection("db")
            .doc("users")
            .collection(_auth.currentUser!.uid)
            .doc()
            .id,
        title: noteModel.title,
        text: noteModel.text,
        createdDate: noteModel.createdDate,
      );

      await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("all_notes")
          .collection("notes")
          .doc(model.id!)
          .set(model.toMap());

      return Success(true);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> updateNote(NoteModel noteModel) async {
    try {
      Loading;

      await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("all_notes")
          .collection("notes")
          .doc(noteModel.id!)
          .set(noteModel.toMap());

      return Success(true);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> deleteNote(String noteId) async {
    try {
      Loading;

      await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("all_notes")
          .collection("notes")
          .doc(noteId)
          .delete();

      return Success(true);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
