import '../../../../../core/resource/resource.dart';
import '../../repository/authentication_repository.dart';

class VerifyEmailUseCase {
  final AuthenticationRepository _authenticationRepository;

  VerifyEmailUseCase(this._authenticationRepository);

  Future<Resource<bool>> call() {
    return _authenticationRepository.verifyEmail();
  }
}
