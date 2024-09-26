import '../../repository/authentication_repository.dart';

class GetUserUidUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetUserUidUseCase(this._authenticationRepository);

  Future<String> call() {
    return _authenticationRepository.getUserUid();
  }
}
