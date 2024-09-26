import 'dart:io';

import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/profile/data/source/remote/profile_source.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileSource _profileSource;

  ProfileRepositoryImpl(this._profileSource);

  @override
  Future<Resource<UserProfileEntity>> getProfile() {
    return _profileSource.getProfile();
  }

  @override
  Future<Resource<bool>> updateProfile(File? img, String name) {
    return _profileSource.updateProfile(img, name);
  }
}
