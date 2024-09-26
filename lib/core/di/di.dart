import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:note_app/features/authentication/data/sources/remote/authentication_source.dart';
import 'package:note_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/get_user_uid_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/is_logged_in_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/login_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/register_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/reset_password_use_case.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/note/data/repository/note_repository_impl.dart';
import 'package:note_app/features/note/data/sources/remote/note_source.dart';
import 'package:note_app/features/note/domain/repository/note_repository.dart';
import 'package:note_app/features/note/domain/use_case/remote/delete_note_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/get_all_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/insert_note_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/search_note_use_case.dart';
import 'package:note_app/features/note/domain/use_case/remote/update_note_use_case.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:note_app/features/profile/data/reposiitory/profile_repository_impl.dart';
import 'package:note_app/features/profile/data/source/remote/profile_source.dart';
import 'package:note_app/features/profile/domain/repository/profile_repository.dart';
import 'package:note_app/features/profile/domain/use_case/remote/get_profile_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/is_email_verified_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/logout_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/update_password_use_case.dart';
import 'package:note_app/features/profile/domain/use_case/remote/update_profile_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/verify_email_use_case.dart';
import 'package:note_app/features/authentication/domain/use_case/remote/get_user_email_use_case.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/domain/use_case/remote/update_email_use_case.dart';
import '../../features/theme/data/repository/local/preferences_repository_impl.dart';
import '../../features/theme/data/sources/local/prefences_source.dart';
import '../../features/theme/domain/repository/local/preferences_repository.dart';
import '../../features/theme/domain/use_case/local/get_theme_use_case.dart';
import '../../features/theme/domain/use_case/local/set_theme_use_case.dart';
import '../../features/theme/presentation/bloc/local/theme/theme_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {
  final preference = await SharedPreferences.getInstance();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  /** Theme */

  singleton.registerSingleton<PreferencesSource>(PreferencesSource(preference));

  singleton.registerSingleton<PreferencesRepository>(
      PreferencesRepositoryImpl(singleton()));

  singleton.registerSingleton<GetThemeUseCase>(GetThemeUseCase(singleton()));

  singleton.registerSingleton<SetThemeUseCase>(SetThemeUseCase(singleton()));

  singleton
      .registerFactory<ThemeBloc>(() => ThemeBloc(singleton(), singleton()));

  /** authentication */

  singleton.registerSingleton<AuthenticationSource>(
      AuthenticationSource(auth, firestore));

  singleton.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(singleton()));

  singleton.registerSingleton<LoginUseCase>(LoginUseCase(singleton()));

  singleton.registerSingleton<RegisterUseCase>(RegisterUseCase(singleton()));

  singleton
      .registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase(singleton()));

  singleton
      .registerSingleton<GetUserUidUseCase>(GetUserUidUseCase(singleton()));

  singleton
      .registerSingleton<GetUserEmailUseCase>(GetUserEmailUseCase(singleton()));

  singleton.registerSingleton<IsEmailVerifiedUseCase>(
      IsEmailVerifiedUseCase(singleton()));

  singleton.registerSingleton<LogoutUseCase>(LogoutUseCase(singleton()));

  singleton
      .registerSingleton<UpdateEmailUseCase>(UpdateEmailUseCase(singleton()));

  singleton.registerSingleton<UpdatePasswordUseCase>(
      UpdatePasswordUseCase(singleton()));

  singleton
      .registerSingleton<VerifyEmailUseCase>(VerifyEmailUseCase(singleton()));

  singleton.registerSingleton<ResetPasswordUseCase>(
      ResetPasswordUseCase(singleton()));

  singleton.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
    ),
  );

  /** profile */

  singleton.registerSingleton<ProfileSource>(
      ProfileSource(auth, firestore, storage));

  singleton
      .registerSingleton<ProfileRepository>(ProfileRepositoryImpl(singleton()));

  singleton
      .registerSingleton<GetProfileUseCase>(GetProfileUseCase(singleton()));

  singleton.registerSingleton<UpdateProfileUseCase>(
      UpdateProfileUseCase(singleton()));

  singleton.registerFactory<ProfileBloc>(
      () => ProfileBloc(singleton(), singleton()));

  /** note */

  singleton.registerSingleton<NoteSource>(NoteSource(auth, firestore));

  singleton.registerSingleton<NoteRepository>(NoteRepositoryImpl(singleton()));

  singleton
      .registerSingleton<InsertNoteUseCase>(InsertNoteUseCase(singleton()));

  singleton
      .registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(singleton()));

  singleton
      .registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(singleton()));

  singleton
      .registerSingleton<SearchNoteUseCase>(SearchNoteUseCase(singleton()));

  singleton
      .registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(singleton()));

  singleton.registerFactory<NoteBloc>(
    () => NoteBloc(
      singleton(),
      singleton(),
      singleton(),
      singleton(),
      singleton(),
    ),
  );
}
