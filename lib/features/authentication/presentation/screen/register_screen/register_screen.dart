import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/common/snackbac_helper.dart';
import 'package:note_app/core/utils/validate_email.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import '../../../../../core/navigation/route_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  late TextEditingController _emailTextFieldController;
  late TextEditingController _nameTextFieldController;
  late TextEditingController _passwordTextFieldController;
  late TextEditingController _passwordConfirmTextFieldController;

  bool _validateEmailTextField = false;
  bool _validateNameTextField = false;
  bool _validatePasswordTextField = false;
  bool _validatePasswordConfirmTextField = false;

  @override
  void initState() {
    super.initState();
    _emailTextFieldController = TextEditingController();
    _nameTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
    _passwordConfirmTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _passwordConfirmTextFieldController.dispose();
    _nameTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is RegisterSuccess) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushNamedAndRemoveUntil(context,
                  RouteNavigation.notesScreen, (Route<dynamic> route) => false);
            },
          );
        } else if (state is RegisterError) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(
              context,
              state.registerException.toString(),
            ),
          );
        } else if (state is RegisterLoading) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, "Creating account..."),
          );
        }
        return _buildRegisterScreen();
      },
    );
  }

  Widget _buildRegisterScreen() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
          child: Text(
            "Register",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
          child: Text(
            "Please fill the inputs below",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: TextField(
            controller: _nameTextFieldController,
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              errorText: _validateNameTextField ? "Enter your name" : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              labelText: "Name",
              prefixIcon: const Icon(Icons.lock),
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (String val) {},
            onChanged: (String val) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: TextField(
            controller: _emailTextFieldController,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            decoration: InputDecoration(
              errorText: _validateEmailTextField ? "Enter valid email" : null,
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
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: TextField(
            controller: _passwordTextFieldController,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              errorText: _validatePasswordTextField
                  ? "Enter a password within at least 9 characters"
                  : null,
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
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: TextField(
            controller: _passwordConfirmTextFieldController,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              errorText: _validatePasswordConfirmTextField
                  ? "Passwords do not match"
                  : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              hintText: "******",
              labelText: "Confirm",
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
              onPressed: () => _register(),
              child: const Text("Register"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNavigation.loginScreen);
            },
            child: Container(
              alignment: Alignment.center,
              child: const Text("Already have an account? Login now"),
            ),
          ),
        )
      ],
    ));
  }

  void _register() {
    setState(() {
      _validateEmailTextField = _emailTextFieldController.text.isEmpty ||
          !isValidEmail(_emailTextFieldController.text);

      _validatePasswordConfirmTextField =
          _passwordConfirmTextFieldController.text.isEmpty ||
              _passwordConfirmTextFieldController.text !=
                  _passwordTextFieldController.text;

      _validatePasswordTextField = _passwordTextFieldController.text.length < 9;

      _validateNameTextField = _nameTextFieldController.text.isEmpty;
    });
    if (!_validateEmailTextField &&
        !_validatePasswordConfirmTextField &&
        !_validatePasswordTextField &&
        !_validateNameTextField) {
      context.read<AuthenticationBloc>().add(
            RegisterEvent(
                _nameTextFieldController.text,
                _passwordTextFieldController.text,
                _emailTextFieldController.text),
          );
    }
  }
}
