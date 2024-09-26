import '../../repository/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase(this._authenticationRepository);

  Future<void> call() {
    return _authenticationRepository.logout();
  }
}
