import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);

  Future<Resource<UserProfileEntity>> call() {
    return _profileRepository.getProfile();
  }
}
