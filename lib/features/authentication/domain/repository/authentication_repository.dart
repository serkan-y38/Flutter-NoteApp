import 'package:note_app/core/resource/resource.dart';

abstract class AuthenticationRepository {
  Future<String> getUserUid();

  Future<String> getUserEmail();

  Future<Resource<bool>> login(String email, String password);

  Future<Resource<bool>> register(String email, String password, String name);

  Future<bool> isLoggedIn();

  Future<Resource<bool>> verifyEmail();

  Future<bool> isEmailVerified();

  Future<Resource<bool>> updateEmail(String newEmail);

  Future<Resource<bool>> updatePassword(String newPassword);

  Future<void> logout();

  Future<Resource<bool>> resetPassword(String email);
}
