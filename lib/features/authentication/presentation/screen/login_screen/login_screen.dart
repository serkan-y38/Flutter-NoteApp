import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app/core/common/build_material_dialog.dart';
import 'package:note_app/core/navigation/route_navigation.dart';
import 'package:note_app/core/utils/validate_email.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import '../../../../../core/common/snackbac_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late TextEditingController _emailTextFieldController;
  late TextEditingController _passwordTextFieldController;

  bool _validateEmailTextField = false;
  bool _validatePasswordTextField = false;

  @override
  void initState() {
    super.initState();
    _emailTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(child: SingleChildScrollView(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationInitialEvent());
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNavigation.notesScreen,
                    (Route<dynamic> route) => false);
              },
            );
          } else if (state is LoginError) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationInitialEvent());
            WidgetsBinding.instance.addPostFrameCallback(
              (callback) => showBasicSnackBar(
                context,
                state.loginException.toString(),
              ),
            );
          } else if (state is LoginLoading) {
            WidgetsBinding.instance.addPostFrameCallback(
              (callback) => showBasicSnackBar(context, "Login loading"),
            );
          } else if (state is ResetPasswordSuccess) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationInitialEvent());
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => showBasicSnackBar(
                  context, "Password reset email sent successfully"),
            );
          } else if (state is ResetPasswordError) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationInitialEvent());
            WidgetsBinding.instance.addPostFrameCallback(
              (callback) => showBasicSnackBar(
                context,
                state.resetPasswordException.toString(),
              ),
            );
          } else if (state is ResetPasswordLoading) {
            WidgetsBinding.instance.addPostFrameCallback(
              (callback) => showBasicSnackBar(context, "ResetPasswordLoading"),
            );
          }
          return SingleChildScrollView(child: _buildLoginScreen());
        },
      ),
    ));
  }

  Widget _buildLoginScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: SvgPicture.asset(
            "assets/password_icon.svg",
            height: 200,
            width: 200,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
          child: Text(
            "Please sign in to continue",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: TextField(
            controller: _emailTextFieldController,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            decoration: InputDecoration(
              errorText: _validatePasswordTextField ? "Enter your email" : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              hintText: "example@mail",
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (String val) {},
            onChanged: (String val) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
          child: TextField(
            controller: _passwordTextFieldController,
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
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _login(),
              child: const Text("Login"),
            ),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () {
              Navigator.pushNamed(context, RouteNavigation.registerScreen);
            },
            child: const Text("Do not have an account? register now")),
        TextButton(
            style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () {
              buildMaterialDialog(
                context,
                title: "Forgot Password?",
                text: "Send a password reset email to entered mail address",
                actionText: "Send",
                dismissible: true,
                action: () => _resetPassword(),
              );
            },
            child: const Text("Forgot password?")),
      ],
    );
  }

  void _login() {
    setState(() {
      _validateEmailTextField = _emailTextFieldController.text.isEmpty;
      _validatePasswordTextField = _passwordTextFieldController.text.isEmpty;
    });

    if (!_validateEmailTextField && !_validatePasswordTextField) {
      context.read<AuthenticationBloc>().add(LoginEvent(
          _emailTextFieldController.text, _passwordTextFieldController.text));
    }
  }

  void _resetPassword() {
    if (_emailTextFieldController.text.isEmpty ||
        !isValidEmail(_emailTextFieldController.text)) {
      showBasicSnackBar(context, "Enter a valid email");
    } else {
      context
          .read<AuthenticationBloc>()
          .add(ResetPasswordEvent(_emailTextFieldController.text));
    }
  }
}
