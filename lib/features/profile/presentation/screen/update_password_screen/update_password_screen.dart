import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/build_material_dialog.dart';
import '../../../../../core/common/snackbac_helper.dart';
import '../../../../authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import '../../../../authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import '../../../../authentication/presentation/bloc/remote/authentication/authentication_state.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UpdatePasswordScreen();
}

class _UpdatePasswordScreen extends State<UpdatePasswordScreen> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordTextFieldController;
  late TextEditingController _newPasswordConfirmTextFieldController;

  bool _validateCurrentPassword = false;
  bool _validateNewPasswordText = false;
  bool _validateNewPasswordConfirmText = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordTextFieldController = TextEditingController();
    _newPasswordConfirmTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordTextFieldController.dispose();
    _newPasswordConfirmTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is UpdatePasswordSuccess) {
          context.read<AuthenticationBloc>().add(LogoutEvent());

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(context, "Password updated successfully");

            _currentPasswordController.clear();
            _newPasswordTextFieldController.clear();
            _newPasswordConfirmTextFieldController.clear();

            _validateCurrentPassword = false;
            _validateNewPasswordText = false;
            _validateNewPasswordConfirmText = false;
          });
        } else if (state is UpdatePasswordError) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              buildMaterialDialog(context,
                  title: "Something Went Wrong",
                  text: state.updatePasswordError.toString(),
                  actionText: "Ok",
                  dismissible: true,
                  action: () {});
            },
          );
        } else if (state is UpdatePasswordLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(context, "Password updating");
          });
        } else if (state is LoginError) {
          context.read<AuthenticationBloc>().add(AuthenticationInitialEvent());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(context, state.loginException.toString());
          });
        } else if (state is LoginLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(context, "Password checking");
          });
        }
        return _buildScreenContent();
      },
    );
  }

  Widget _buildScreenContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: Icon(
              Icons.password,
              color: Theme.of(context).colorScheme.onSurface,
              size: 124,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: TextField(
              controller: _currentPasswordController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                errorText:
                    _validateCurrentPassword ? "Enter your password" : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                hintText: "******",
                labelText: "Current Password",
                prefixIcon: const Icon(Icons.lock),
                border: const UnderlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (String val) {},
              onChanged: (String val) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: TextField(
              controller: _newPasswordTextFieldController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                errorText: _validateNewPasswordText
                    ? "Enter a password within at least 9 characters"
                    : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                hintText: "******",
                labelText: "New Password",
                prefixIcon: const Icon(Icons.lock),
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
              controller: _newPasswordConfirmTextFieldController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                errorText: _validateNewPasswordConfirmText
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _updatePassword(),
                child: const Text("Update"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updatePassword() {
    setState(() {
      _validateCurrentPassword = _currentPasswordController.text.isEmpty;
      _validateNewPasswordText =
          _newPasswordTextFieldController.text.length < 9;
      _validateNewPasswordConfirmText =
          _newPasswordConfirmTextFieldController.text !=
              _newPasswordTextFieldController.text;
    });

    if (!_validateCurrentPassword &&
        !_validateNewPasswordConfirmText &&
        !_validateNewPasswordText) {
      String? email = context.read<AuthenticationBloc>().state.email;
      context.read<AuthenticationBloc>().add(UpdatePasswordEvent(
            _newPasswordTextFieldController.text,
            _currentPasswordController.text,
            email ?? "",
          ));
    }
  }
}
