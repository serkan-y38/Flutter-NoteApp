import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_bloc.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_event.dart';
import 'package:note_app/features/authentication/presentation/bloc/remote/authentication/authentication_state.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_bloc.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_state.dart';
import '../../../../../core/navigation/route_navigation.dart';
import '../../../../../core/theme/theme_utils.dart';
import '../../../../theme/presentation/bloc/local/theme/theme_bloc.dart';
import '../../../../theme/presentation/bloc/local/theme/theme_event.dart';
import '../../bloc/remote/profile_event.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileDetailsScreen();
}

class _ProfileDetailsScreen extends State<ProfileDetailsScreen> {
  AppTheme? _theme;
  String _userEmail = "";

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<AuthenticationBloc>().add(GetUserEmailEvent());
    _theme = context.read<ThemeBloc>().state.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => _logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          return _buildScreen(state.userProfileEntity!);
        } else if (state is GetProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProfileError) {
          return const Center(child: Icon(Icons.error));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildScreen(UserProfileEntity entity) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildUserProfileRow(entity),
          _buildUpdateProfileButton(entity),
          _buildAuthenticateSettings(),
          _buildThemeSetting()
        ],
      ),
    );
  }

  Widget _buildUserProfileRow(UserProfileEntity entity) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _buildCircularImage(url: entity.ppUrl!),
          _buildNameEmailText(entity.name!)
        ],
      ),
    );
  }

  Widget _buildCircularImage({required String url}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      child: ClipOval(
        child: (url.isNotEmpty)
            ? CachedNetworkImage(
                width: 96,
                height: 96,
                imageUrl: url,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 4,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const Icon(
                Icons.person,
                size: 96,
              ),
      ),
    );
  }

  Widget _buildNameEmailText(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is GetUserEmailSuccess) {
              _userEmail = state.email!;
              return Text(_userEmail);
            }
            return const Text("state.email!");
          }),
        ),
      ],
    );
  }

  Widget _buildUpdateProfileButton(UserProfileEntity entity) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: () => Navigator.pushNamed(
              context, RouteNavigation.updateProfileScreen,
              arguments: (entity)),
          child: const Text("Update Profile"),
        ),
      ),
    );
  }

  Widget _buildAuthenticateSettings() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                minTileHeight: 48,
                contentPadding: EdgeInsets.zero,
                title: const Text("Verify email"),
                leading: const Icon(Icons.verified_outlined),
                onTap: () => Navigator.pushNamed(
                    context, RouteNavigation.verifyEmailScreen),
              ),
              ListTile(
                minTileHeight: 48,
                contentPadding: EdgeInsets.zero,
                title: const Text("Update email"),
                leading: const Icon(Icons.alternate_email_outlined),
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteNavigation.updateEmailScreen,
                  arguments: _userEmail,
                ),
              ),
              ListTile(
                minTileHeight: 48,
                contentPadding: EdgeInsets.zero,
                title: const Text("Update password"),
                leading: const Icon(Icons.password),
                onTap: () => Navigator.pushNamed(
                    context, RouteNavigation.updatePasswordScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSetting() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 8),
                  child: Text(
                    "Theme",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: const Text("System settings"),
                  leading: Radio<AppTheme>(
                    value: AppTheme.systemSetting,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeBloc>().add(SetTheme(_theme!));
                      });
                    },
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Dark"),
                  leading: Radio<AppTheme>(
                    value: AppTheme.dark,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeBloc>().add(SetTheme(_theme!));
                      });
                    },
                  ),
                ),
                ListTile(
                  minTileHeight: 48,
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Light"),
                  leading: Radio<AppTheme>(
                    value: AppTheme.light,
                    groupValue: _theme,
                    onChanged: (AppTheme? value) {
                      setState(() {
                        _theme = value;
                        context.read<ThemeBloc>().add(SetTheme(_theme!));
                      });
                    },
                  ),
                ),
              ],
            )));
  }

  void _logout() {
    context.read<AuthenticationBloc>().add(LogoutEvent());
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNavigation.loginScreen,
      (Route<dynamic> route) => false,
    );
  }
}
