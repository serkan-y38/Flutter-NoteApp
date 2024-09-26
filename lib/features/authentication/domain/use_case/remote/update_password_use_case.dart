import 'package:note_app/core/resource/resource.dart';
import '../../repository/authentication_repository.dart';

class UpdatePasswordUseCase {
  final AuthenticationRepository _authenticationRepository;

  UpdatePasswordUseCase(this._authenticationRepository);

  Future<Resource<bool>> call(String newPassword) {
    return _authenticationRepository.updatePassword(newPassword);
  }
}
