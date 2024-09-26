import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/di/di.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:note_app/features/note/presentation/bloc/note_event.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_bloc.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_event.dart';
import 'package:note_app/features/theme/presentation/bloc/local/theme/theme_bloc.dart';
import 'package:note_app/features/theme/presentation/bloc/local/theme/theme_event.dart';
import 'core/navigation/route_navigation.dart';
import 'core/navigation/router.dart';
import 'core/theme/theme_utils.dart';
import 'features/theme/presentation/bloc/local/theme/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(
        create: (context) => singleton()..add(const GetTheme())),
    BlocProvider<AuthenticationBloc>(
        create: (context) => singleton()..add(IsLoggedInEvent())),
    BlocProvider<ProfileBloc>(
      create: (context) => singleton()..add(GetProfileEvent()),
    ),
    BlocProvider<NoteBloc>(
      create: (context) => singleton()..add(InitialNoteEvent()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeUtils.getThemeData(state.theme, context),
          title: 'Note app',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouterClass.generateRoute,
          initialRoute: RouteNavigation.initialScreen,
        );
      },
    );
  }
}
