import 'package:note_app/core/resource/resource.dart';
import '../../repository/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  Future<Resource<bool>> call(String password, String email) {
    return _authenticationRepository.login(email, password);
  }
}
