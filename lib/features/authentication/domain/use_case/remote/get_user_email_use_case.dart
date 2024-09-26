import 'package:note_app/features/authentication/domain/repository/authentication_repository.dart';

class GetUserEmailUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetUserEmailUseCase(this._authenticationRepository);

  Future<String> call() {
    return _authenticationRepository.getUserEmail();
  }
}
