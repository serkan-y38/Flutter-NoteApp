import 'package:note_app/features/authentication/domain/repository/authentication_repository.dart';

class IsLoggedInUseCase {
  final AuthenticationRepository _authenticationRepository;

  IsLoggedInUseCase(this._authenticationRepository);

  Future<bool> call() {
    return _authenticationRepository.isLoggedIn();
  }
}
