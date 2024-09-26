import 'dart:io';

class ProfileEvent {
  String? name;
  File? img;

  ProfileEvent({this.name, this.img});
}

class InitialProfileEvent extends ProfileEvent {
  InitialProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  UpdateProfileEvent(String name, File? img) : super(name: name, img: img);
}
