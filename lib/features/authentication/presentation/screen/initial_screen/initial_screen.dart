import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/navigation/route_navigation.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';

import '../../bloc/remote/authentication/authentication_event.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InitialScreen();
}

class _InitialScreen extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is IsLoggedInSuccess) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationInitialEvent());
            WidgetsBinding.instance.addPostFrameCallback((_) {
              (!state.isLoggedIn!)
                  ? Navigator.pushNamed(context, RouteNavigation.loginScreen)
                  : Navigator.pushNamed(context, RouteNavigation.notesScreen);
            });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
