import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';

class UserProfileModel {
  final String? uid;
  final String? name;
  final String? ppUrl;

  UserProfileModel({this.uid, this.name, this.ppUrl});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid!,
      'name': name!,
      'ppUrl': ppUrl!,
    };
  }

  UserProfileEntity modelToEntity() {
    return UserProfileEntity(uid, name, ppUrl);
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        uid: json['uid'] ?? "",
        name: json['name'] ?? "",
        ppUrl: json['ppUrl'] ?? "");
  }
}
