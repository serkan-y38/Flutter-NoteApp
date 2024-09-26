abstract class AuthenticationState {
  final Exception? loginException;
  final Exception? logoutException;
  final Exception? registerException;
  final Exception? getUserUidException;
  final Exception? resetPasswordException;
  final String? userUid;
  final bool? isLoggedIn;
  final bool? isEmailVerified;
  final Exception? updatePasswordError;
  final Exception? updateEmailError;
  final Exception? verifyEmailError;
  final String? email;

  const AuthenticationState({
    this.resetPasswordException,
    this.email,
    this.loginException,
    this.registerException,
    this.logoutException,
    this.getUserUidException,
    this.userUid,
    this.isLoggedIn,
    this.isEmailVerified,
    this.updatePasswordError,
    this.updateEmailError,
    this.verifyEmailError,
  });
}

/*
* initial state
*/

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

/*
* getEmail
*/

class GetUserEmailSuccess extends AuthenticationState {
  const GetUserEmailSuccess(String email) : super(email: email);
}

/*
* GetUserUid
*/
class GetUserUidSuccess extends AuthenticationState {
  const GetUserUidSuccess(String uid) : super(userUid: uid);
}

/*
* isEmailVerified
*/

class IsEmailVerifiedSuccess extends AuthenticationState {
  const IsEmailVerifiedSuccess(bool b) : super(isEmailVerified: b);
}

/*
* logout
*/

class LogoutSuccess extends AuthenticationState {
  const LogoutSuccess();
}

/*
* IsLoggedIn
*/
class IsLoggedInSuccess extends AuthenticationState {
  const IsLoggedInSuccess(bool isLoggedIn) : super(isLoggedIn: isLoggedIn);
}

/*
* Register
*/
class RegisterSuccess extends AuthenticationState {
  const RegisterSuccess();
}

class RegisterLoading extends AuthenticationState {
  const RegisterLoading();
}

class RegisterError extends AuthenticationState {
  const RegisterError(Exception e) : super(registerException: e);
}

/*
* reset Password
*/
class ResetPasswordSuccess extends AuthenticationState {
  const ResetPasswordSuccess();
}

class ResetPasswordLoading extends AuthenticationState {
  const ResetPasswordLoading();
}

class ResetPasswordError extends AuthenticationState {
  const ResetPasswordError(Exception e) : super(resetPasswordException: e);
}

/*
 * Login
 */
class LoginSuccess extends AuthenticationState {
  const LoginSuccess();
}

class LoginLoading extends AuthenticationState {
  const LoginLoading();
}

class LoginError extends AuthenticationState {
  const LoginError(Exception e) : super(loginException: e);
}

/*
* VerifyEmail
*/

class VerifyEmailSuccess extends AuthenticationState {
  const VerifyEmailSuccess();
}

class VerifyEmailLoading extends AuthenticationState {
  const VerifyEmailLoading();
}

class VerifyEmailError extends AuthenticationState {
  const VerifyEmailError(Exception e) : super(verifyEmailError: e);
}

/*
* updateEmail
*/

class UpdateEmailSuccess extends AuthenticationState {
  const UpdateEmailSuccess();
}

class UpdateEmailLoading extends AuthenticationState {
  const UpdateEmailLoading();
}

class UpdateEmailError extends AuthenticationState {
  const UpdateEmailError(Exception e) : super(updateEmailError: e);
}

/*
* updatePassword
*/

class UpdatePasswordSuccess extends AuthenticationState {
  const UpdatePasswordSuccess();
}

class UpdatePasswordLoading extends AuthenticationState {
  const UpdatePasswordLoading();
}

class UpdatePasswordError extends AuthenticationState {
  const UpdatePasswordError(Exception e) : super(updatePasswordError: e);
}
