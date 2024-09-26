import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/common/build_material_dialog.dart';
import 'package:note_app/core/utils/validate_email.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import '../../../../../core/common/snackbac_helper.dart';
import '../../../../../core/navigation/route_navigation.dart';
import '../../../../authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import '../../../../authentication/presentation/bloc/remote/authentication/authentication_event.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({super.key, required this.currentEmail});

  final String currentEmail;

  @override
  State<StatefulWidget> createState() => _UpdateEmailScreen();
}

class _UpdateEmailScreen extends State<UpdateEmailScreen> {
  late TextEditingController _newEmailEditTextController;
  late TextEditingController _passwordEditTextController;

  bool _validatePasswordTextField = false;
  bool _validateNewEmailTextField = false;

  @override
  void initState() {
    super.initState();
    _newEmailEditTextController = TextEditingController();
    _passwordEditTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newEmailEditTextController.dispose();
    _passwordEditTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Email"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is UpdateEmailSuccess) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              buildMaterialDialog(context,
                  title: "A verification email has been sent",
                  text:
                      "Please check your inbox and verify your new email address. Once verified, you can login using your new email",
                  actionText: "Ok",
                  dismissible: true,
                  action: () {});
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushNamedAndRemoveUntil(context,
                  RouteNavigation.loginScreen, (Route<dynamic> route) => false);
            },
          );
        } else if (state is UpdateEmailError) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              showBasicSnackBar(context, state.updateEmailError.toString());
            },
          );
        } else if (state is UpdateEmailLoading) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, "Email updating..."),
          );
        } else if (state is LoginError) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(
              context,
              state.loginException.toString(),
            );
          });
        } else if (state is LoginLoading) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              showBasicSnackBar(context, "Password checking");
            },
          );
        }
        return _buildScreenContent();
      },
    );
  }

  Widget _buildScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.alternate_email,
                size: 96,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Update email address"),
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _newEmailEditTextController,
            maxLines: 1,
            decoration: InputDecoration(
              errorText:
                  _validateNewEmailTextField ? "Enter valid email" : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              hintText: "example@mail.com",
              labelText: "New Email",
              prefixIcon: const Icon(Icons.email),
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (String val) {},
            onChanged: (String val) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: TextField(
            controller: _passwordEditTextController,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              errorText:
                  _validatePasswordTextField ? "Enter your password" : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              hintText: "******",
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock),
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (String val) {},
            onChanged: (String val) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _updateEmail(),
              child: const Text("Update"),
            ),
          ),
        ),
      ],
    );
  }

  _updateEmail() {
    setState(() {
      _validateNewEmailTextField = _newEmailEditTextController.text.isEmpty ||
          !isValidEmail(_newEmailEditTextController.text);
      _validatePasswordTextField = _passwordEditTextController.text.isEmpty;
    });

    if (!_validatePasswordTextField && !_validateNewEmailTextField) {
      String newEmail = _newEmailEditTextController.text;
      String password = _passwordEditTextController.text;
      context
          .read<AuthenticationBloc>()
          .add(UpdateEmailEvent(newEmail, widget.currentEmail, password));
    }
  }
}
