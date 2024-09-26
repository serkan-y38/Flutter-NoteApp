import '../../repository/authentication_repository.dart';

class IsEmailVerifiedUseCase {
  final AuthenticationRepository _authenticationRepository;

  IsEmailVerifiedUseCase(this._authenticationRepository);

  Future<bool> call() {
    return _authenticationRepository.isEmailVerified();
  }
}
