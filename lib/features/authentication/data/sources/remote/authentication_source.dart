import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/features/profile/data/model/user_profile_model.dart';
import '../../../../../core/resource/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;

  AuthenticationSource(this._auth, this._firebaseFirestore);

  Future<String> getUserUid() async {
    return _auth.currentUser?.uid ?? "";
  }

  Future<String> getUserEmail() async {
    return _auth.currentUser?.email ?? "";
  }

  Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  Future<bool> isEmailVerified() async {
    _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Resource<bool>> login(String email, String password) async {
    try {
      Loading;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> register(
      String email, String password, String name) async {
    try {
      Loading;
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        if (_auth.currentUser != null) {
          _firebaseFirestore
              .collection("db")
              .doc("users")
              .collection(_auth.currentUser!.uid)
              .doc("profile")
              .set(UserProfileModel(
                      uid: _auth.currentUser!.uid, name: name, ppUrl: "")
                  .toMap());
        }
      });
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> updateEmail(String newEmail) async {
    try {
      Loading;
      await _auth.currentUser!.verifyBeforeUpdateEmail(newEmail);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> updatePassword(String newPassword) async {
    try {
      Loading;
      await _auth.currentUser!.updatePassword(newPassword);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> verifyEmail() async {
    try {
      Loading;
      await _auth.currentUser!.sendEmailVerification();
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> resetPassword(String email) async {
    try {
      Loading;
      await _auth.sendPasswordResetEmail(email: email);
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
