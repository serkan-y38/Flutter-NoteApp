import '../../../../../core/resource/resource.dart';
import '../../repository/authentication_repository.dart';

class UpdateEmailUseCase {
  final AuthenticationRepository _authenticationRepository;

  UpdateEmailUseCase(this._authenticationRepository);

  Future<Resource<bool>> call(String newEmail) {
    return _authenticationRepository.updateEmail(newEmail);
  }
}
