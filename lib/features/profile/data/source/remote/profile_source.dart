import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:note_app/features/profile/data/model/user_profile_model.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import '../../../../../core/resource/resource.dart';

class ProfileSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ProfileSource(this._auth, this._firebaseFirestore, this._firebaseStorage);

  Future<Resource<UserProfileEntity>> getProfile() async {
    try {
      Loading;
      final res = await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("profile")
          .get();
      return Success(UserProfileModel.fromJson(res.data()!).modelToEntity());
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> updateProfile(File? img, String name) async {
    try {
      Loading;
      await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("profile")
          .update({'name': name});
      if (img != null) {
        return _updatePP(img);
      }
      return Success(true);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> _updatePP(File img) async {
    try {
      Loading;

      var uid = _auth.currentUser!.uid;
      var ppStorageRef =
          _firebaseStorage.ref().child("user_profile_photos").child(uid);

      await ppStorageRef.putFile(img).whenComplete(() async {
        var url = await ppStorageRef.getDownloadURL();
        if (url.isNotEmpty) {
          return _updateUserPPField(url);
        }
      });

      return Success(false);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Resource<bool>> _updateUserPPField(String url) async {
    try {
      Loading;
      await _firebaseFirestore
          .collection("db")
          .doc("users")
          .collection(_auth.currentUser!.uid)
          .doc("profile")
          .update({"ppUrl": url});
      return Success(true);
    } on FirebaseException catch (e) {
      return Error(e);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
