import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/resource/resource.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/domain/use_case/remote/get_profile_use_case.dart';
import 'package:note_app/features/profile/domain/use_case/remote/update_profile_use_case.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_event.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileBloc(
    this._getProfileUseCase,
    this._updateProfileUseCase,
  ) : super(const GetProfileLoading()) {
    on<GetProfileEvent>(onGetProfile);
    on<UpdateProfileEvent>(onUpdateProfile);
    on<InitialProfileEvent>(onInitialState);
  }

  void onInitialState(ProfileEvent event, Emitter<ProfileState> emitter) async {
    emitter(const InitialProfileState());
  }

  void onGetProfile(ProfileEvent event, Emitter<ProfileState> emitter) async {
    final res = await _getProfileUseCase.call();
    if (res is Success<UserProfileEntity>) {
      emitter(GetProfileSuccess(res.data!));
    } else if (res is Error) {
      emitter(GetProfileError(res.e!));
    } else {
      emitter(const GetProfileLoading());
    }
  }

  void onUpdateProfile(
      ProfileEvent event, Emitter<ProfileState> emitter) async {
    final state = await _updateProfileUseCase.call(event.img, event.name!);
    if (state is Success<bool>) {
      emitter(const UpdateProfileSuccess());
    } else if (state is Error) {
      emitter(UpdateProfileError(state.e!));
    } else {
      emitter(const UpdateProfileLoading());
    }
  }
}
