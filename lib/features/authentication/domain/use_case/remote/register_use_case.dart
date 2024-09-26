import '../../../../../core/resource/resource.dart';
import '../../repository/authentication_repository.dart';

class RegisterUseCase {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  Future<Resource<bool>> call(String password, String email, String username) {
    return _authenticationRepository.register(email, password, username);
  }
}
