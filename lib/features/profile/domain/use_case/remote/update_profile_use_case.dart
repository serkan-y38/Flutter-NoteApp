import 'dart:io';
import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  Future<Resource<bool>> call(File? img, String name) {
    return _profileRepository.updateProfile(img, name);
  }
}
