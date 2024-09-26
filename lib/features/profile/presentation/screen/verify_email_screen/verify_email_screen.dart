import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/common/snackbac_helper.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import '../../../../../core/common/build_material_dialog.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VerifyEmailScreen();
}

class _VerifyEmailScreen extends State<VerifyEmailScreen> {
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(IsEmailVerifiedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is IsEmailVerifiedSuccess) {
        _isEmailVerified = state.isEmailVerified!;
      } else if (state is VerifyEmailSuccess) {
        context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buildMaterialDialog(context,
              title: "A verification email has been sent",
              text: "Please check your inbox and verify your email address.",
              actionText: "Ok",
              dismissible: true,
              action: () {});
        });
      } else if (state is VerifyEmailError) {
        context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showBasicSnackBar(context, state.verifyEmailError.toString());
        });
      } else if (state is VerifyEmailLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showBasicSnackBar(context, "Loading...");
        });
      }
      return _buildScreenContent();
    });
  }

  Widget _buildScreenContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.verified_outlined,
                  size: 96,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: (_isEmailVerified)
                      ? const Text("Your email address has been verified")
                      : const Text("Your email address has not been verified"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(VerifyEmailEvent()),
                child: const Text("Send Verification Email"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
