import '../../../domain/entity/user_profile_entity.dart';

class ProfileState {
  final UserProfileEntity? userProfileEntity;
  final Exception? getProfileError;
  final Exception? updateProfileError;

  const ProfileState({
    this.userProfileEntity,
    this.getProfileError,
    this.updateProfileError,
  });
}

class InitialProfileState extends ProfileState {
  const InitialProfileState();
}

/*
* getProfile
*/
class GetProfileSuccess extends ProfileState {
  const GetProfileSuccess(UserProfileEntity e) : super(userProfileEntity: e);
}

class GetProfileLoading extends ProfileState {
  const GetProfileLoading();
}

class GetProfileError extends ProfileState {
  const GetProfileError(Exception e) : super(getProfileError: e);
}

/*
* updateProfile
*/
class UpdateProfileSuccess extends ProfileState {
  const UpdateProfileSuccess();
}

class UpdateProfileLoading extends ProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileError extends ProfileState {
  const UpdateProfileError(Exception e) : super(updateProfileError: e);
}
