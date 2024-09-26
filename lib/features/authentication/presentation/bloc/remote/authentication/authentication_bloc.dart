import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/get_user_email_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/get_user_uid_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/is_logged_in_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/login_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/register_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/reset_password_use_case.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import '../../../../domain/use_case/remote/is_email_verified_use_case.dart';
import '../../../../domain/use_case/remote/logout_use_case.dart';
import '../../../../domain/use_case/remote/update_email_use_case.dart';
import '../../../../domain/use_case/remote/update_password_use_case.dart';
import '../../../../domain/use_case/remote/verify_email_use_case.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserUidUseCase _getUserUidUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final IsEmailVerifiedUseCase _isEmailVerifiedUseCase;
  final UpdateEmailUseCase _updateEmailUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final GetUserEmailUseCase _getUserEmailUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthenticationBloc(
    this._resetPasswordUseCase,
    this._getUserEmailUseCase,
    this._getUserUidUseCase,
    this._isLoggedInUseCase,
    this._loginUseCase,
    this._registerUseCase,
    this._isEmailVerifiedUseCase,
    this._logoutUseCase,
    this._updateEmailUseCase,
    this._updatePasswordUseCase,
    this._verifyEmailUseCase,
  ) : super(const AuthenticationInitialState()) {
    on<GetUserUidEvent>(onGetUserUid);
    on<IsLoggedInEvent>(onIsLoggedIn);
    on<RegisterEvent>(onRegister);
    on<LoginEvent>(onLogin);
    on<LogoutEvent>(onLogout);
    on<GetUserEmailEvent>(onGetUserEmail);
    on<IsEmailVerifiedEvent>(onIsEmailVerified);
    on<UpdatePasswordEvent>(onUpdatePassword);
    on<UpdateEmailEvent>(onUpdateEmail);
    on<VerifyEmailEvent>(onVerifyEmail);
    on<ResetPasswordEvent>(onResetPassword);
    on<AuthenticationInitialEvent>(onAuthenticationInitialEvent);
  }

  void onAuthenticationInitialEvent(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) {
    emitter(const AuthenticationInitialState());
  }

  void onIsLoggedIn(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final state = await _isLoggedInUseCase.call();
    emitter(IsLoggedInSuccess(state));
  }

  void onRegister(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final state = await _registerUseCase.call(
        event.registerPassword!, event.registerEmail!, event.registerUsername!);
    if (state is Success<bool>) {
      emitter(const RegisterSuccess());
    } else if (state is Error) {
      emitter(RegisterError(state.e!));
    } else {
      emitter(const RegisterLoading());
    }
  }

  void onLogin(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final state =
        await _loginUseCase.call(event.loginPassword!, event.loginEmail!);
    if (state is Success<bool>) {
      emitter(const LoginSuccess());
    } else if (state is Error) {
      emitter(LoginError(state.e!));
    } else {
      emitter(const LoginLoading());
    }
  }

  void onLogout(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    await _logoutUseCase.call();
    emitter(const LogoutSuccess());
    emitter(const IsLoggedInSuccess(false));
  }

  void onGetUserEmail(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final mail = await _getUserEmailUseCase.call();
    emitter(GetUserEmailSuccess(mail));
  }

  void onGetUserUid(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final uid = await _getUserUidUseCase.call();
    emitter(GetUserUidSuccess(uid));
  }

  void onIsEmailVerified(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final mail = await _isEmailVerifiedUseCase.call();
    emitter(IsEmailVerifiedSuccess(mail));
  }

  void onUpdatePassword(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final stateLogin =
        await _loginUseCase.call(event.loginPassword!, event.loginEmail!);

    if (stateLogin is Success<bool>) {
      final updateState = await _updatePasswordUseCase.call(event.newPassword!);
      if (updateState is Success<bool>) {
        emitter(const UpdatePasswordSuccess());
      } else if (updateState is Error) {
        emitter(UpdatePasswordError(updateState.e!));
      } else {
        emitter(const UpdatePasswordLoading());
      }
    } else if (stateLogin is Error) {
      emitter(LoginError(stateLogin.e!));
    } else {
      emitter(const LoginLoading());
    }
  }

  void onUpdateEmail(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final stateLogin =
        await _loginUseCase.call(event.loginPassword!, event.loginEmail!);

    if (stateLogin is Success<bool>) {
      final state = await _updateEmailUseCase.call(event.newEmail!);

      if (state is Success<bool>) {
        emitter(const UpdateEmailSuccess());
      } else if (state is Error) {
        emitter(UpdateEmailError(state.e!));
      } else {
        emitter(const UpdateEmailLoading());
      }
    } else if (stateLogin is Error) {
      emitter(LoginError(stateLogin.e!));
    } else {
      emitter(const LoginLoading());
    }
  }

  void onVerifyEmail(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final state = await _verifyEmailUseCase.call();
    if (state is Success<bool>) {
      emitter(const VerifyEmailSuccess());
    } else if (state is Error) {
      emitter(VerifyEmailError(state.e!));
    } else {
      emitter(const VerifyEmailLoading());
    }
  }

  void onResetPassword(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    final state = await _resetPasswordUseCase.call(event.loginEmail!);
    if (state is Success<bool>) {
      emitter(const ResetPasswordSuccess());
    } else if (state is Error) {
      emitter(ResetPasswordError(state.e!));
    } else {
      emitter(const ResetPasswordLoading());
    }
  }
}
