import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/authentication/data/sources/remote/authentication_source.dart';
import 'package:note_app/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationSource _authenticationSource;

  AuthenticationRepositoryImpl(this._authenticationSource);

  @override
  Future<String> getUserUid() {
    return _authenticationSource.getUserUid();
  }

  @override
  Future<bool> isLoggedIn() {
    return _authenticationSource.isLoggedIn();
  }

  @override
  Future<Resource<bool>> login(String email, String password) {
    return _authenticationSource.login(email, password);
  }

  @override
  Future<Resource<bool>> register(String email, String password, String name) {
    return _authenticationSource.register(email, password, name);
  }

  @override
  Future<Resource<bool>> verifyEmail() {
    return _authenticationSource.verifyEmail();
  }

  @override
  Future<bool> isEmailVerified() {
    return _authenticationSource.isEmailVerified();
  }

  @override
  Future<void> logout() {
    return _authenticationSource.logout();
  }

  @override
  Future<Resource<bool>> updateEmail(String newEmail) {
    return _authenticationSource.updateEmail(newEmail);
  }

  @override
  Future<Resource<bool>> updatePassword(String newPassword) {
    return _authenticationSource.updatePassword(newPassword);
  }

  @override
  Future<String> getUserEmail() {
    return _authenticationSource.getUserEmail();
  }

  @override
  Future<Resource<bool>> resetPassword(String email) {
    return _authenticationSource.resetPassword(email);
  }
}
