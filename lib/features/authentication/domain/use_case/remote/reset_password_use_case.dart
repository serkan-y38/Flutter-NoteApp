import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/authentication/domain/repository/authentication_repository.dart';

class ResetPasswordUseCase {
  final AuthenticationRepository _authenticationRepository;

  ResetPasswordUseCase(this._authenticationRepository);

  Future<Resource<bool>> call(String email) {
    return _authenticationRepository.resetPassword(email);
  }
}
