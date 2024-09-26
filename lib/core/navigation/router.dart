import 'package:flutter/material.dart';
import 'package:note_app/core/navigation/route_navigation.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/presentation/screen/create_note_screen/create_note_screen.dart';
import 'package:note_app/features/note/presentation/screen/note_details_screen/note_details_screen.dart';
import 'package:note_app/features/note/presentation/screen/notes_screen/notes_screen.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/presentation/screen/profile_details_screen/profile_details_screen.dart';
import 'package:note_app/features/profile/presentation/screen/update_email_screen/update_email_screen.dart';
import 'package:note_app/features/profile/presentation/screen/update_password_screen/update_password_screen.dart';
import 'package:note_app/features/profile/presentation/screen/update_profile_screen/update_profile_screen.dart';
import 'package:note_app/features/profile/presentation/screen/verify_email_screen/verify_email_screen.dart';
import '../../features/authentication/presentation/screen/initial_screen/initial_screen.dart';
import '../../features/authentication/presentation/screen/login_screen/login_screen.dart';
import '../../features/authentication/presentation/screen/register_screen/register_screen.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNavigation.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNavigation.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteNavigation.notesScreen:
        return MaterialPageRoute(builder: (_) => const NotesScreen());
      case RouteNavigation.initialScreen:
        return MaterialPageRoute(builder: (_) => const InitialScreen());
      case RouteNavigation.profileDetailsScreen:
        return MaterialPageRoute(builder: (_) => const ProfileDetailsScreen());
      case RouteNavigation.updatePasswordScreen:
        return MaterialPageRoute(builder: (_) => const UpdatePasswordScreen());
      case RouteNavigation.verifyEmailScreen:
        return MaterialPageRoute(builder: (_) => const VerifyEmailScreen());
      case RouteNavigation.createNoteScreen:
        return MaterialPageRoute(builder: (_) => const CreateNoteScreen());
      case RouteNavigation.noteDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => NoteDetailsScreen(
                  noteEntity: settings.arguments as NoteEntity,
                ));
      case RouteNavigation.updateProfileScreen:
        return MaterialPageRoute(
            builder: (_) => UpdateProfileScreen(
                  entity: settings.arguments as UserProfileEntity,
                ));
      case RouteNavigation.updateEmailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                UpdateEmailScreen(currentEmail: settings.arguments as String));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
