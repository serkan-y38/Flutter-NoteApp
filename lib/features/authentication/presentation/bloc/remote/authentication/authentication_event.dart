class AuthenticationEvent {
  String? registerUsername;
  String? registerPassword;
  String? registerEmail;
  String? loginEmail;
  String? loginPassword;
  String? newPassword;
  String? newEmail;

  AuthenticationEvent({
    this.registerUsername,
    this.registerPassword,
    this.registerEmail,
    this.loginEmail,
    this.loginPassword,
    this.newEmail,
    this.newPassword,
  });
}

class AuthenticationInitialEvent extends AuthenticationEvent {
  AuthenticationInitialEvent();
}

class LoginEvent extends AuthenticationEvent {
  LoginEvent(String mail, String password)
      : super(loginPassword: password, loginEmail: mail);
}

class RegisterEvent extends AuthenticationEvent {
  RegisterEvent(String username, String password, String email)
      : super(
          registerEmail: email,
          registerPassword: password,
          registerUsername: username,
        );
}

class ResetPasswordEvent extends AuthenticationEvent {
  ResetPasswordEvent(String email) : super(loginEmail: email);
}

class GetUserEmailEvent extends AuthenticationEvent {
  GetUserEmailEvent();
}

class GetUserUidEvent extends AuthenticationEvent {
  GetUserUidEvent();
}

class IsLoggedInEvent extends AuthenticationEvent {
  IsLoggedInEvent();
}

class IsEmailVerifiedEvent extends AuthenticationEvent {
  IsEmailVerifiedEvent();
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}

class UpdateEmailEvent extends AuthenticationEvent {
  UpdateEmailEvent(String newEmail, String currentEmail, String password)
      : super(
          newEmail: newEmail,
          loginEmail: currentEmail,
          loginPassword: password,
        );
}

class UpdatePasswordEvent extends AuthenticationEvent {
  UpdatePasswordEvent(String newPassword, String currentPassword, String email)
      : super(
          newPassword: newPassword,
          loginPassword: currentPassword,
          loginEmail: email,
        );
}

class VerifyEmailEvent extends AuthenticationEvent {
  VerifyEmailEvent();
}
