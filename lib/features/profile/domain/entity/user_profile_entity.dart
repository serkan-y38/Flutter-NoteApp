import 'package:note_app/features/profile/data/model/user_profile_model.dart';

class UserProfileEntity {
  final String? uid;
  final String? name;
  final String? ppUrl;

  UserProfileEntity(this.uid, this.name, this.ppUrl);

  UserProfileModel toUserModel() {
    return UserProfileModel(uid: uid, name: name, ppUrl: ppUrl);
  }
}
