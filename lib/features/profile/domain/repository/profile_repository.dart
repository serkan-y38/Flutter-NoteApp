import 'dart:io';
import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<Resource<bool>> updateProfile(File? img, String name);

  Future<Resource<UserProfileEntity>> getProfile();
}
