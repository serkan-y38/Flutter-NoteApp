import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/common/snackbac_helper.dart';
import 'package:note_app/features/profile/domain/entity/user_profile_entity.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_bloc.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_event.dart';
import 'package:note_app/features/profile/presentation/bloc/remote/profile_state.dart';
import 'package:note_app/features/profile/presentation/screen/update_profile_screen/widget/build_circular_image.dart';
import 'package:note_app/features/profile/presentation/screen/update_profile_screen/widget/build_name_edit_text.dart';
import 'package:note_app/features/profile/presentation/screen/update_profile_screen/widget/build_update_button.dart';
import 'package:note_app/features/profile/presentation/screen/update_profile_screen/widget/pick_photo_options_dialog.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.entity});

  final UserProfileEntity entity;

  @override
  State<StatefulWidget> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  late TextEditingController _nameTextFieldController;
  late UserProfileEntity entity;

  bool _validateNameTextField = false;

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    entity = widget.entity;
    _nameTextFieldController = TextEditingController()..text = entity.name!;
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is UpdateProfileSuccess) {
        context.read<ProfileBloc>().add(InitialProfileEvent());
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(context, "Changes saved successfully"),
        );
      } else if (state is UpdateProfileError) {
        context.read<ProfileBloc>().add(InitialProfileEvent());
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(
            context,
            state.updateProfileError.toString(),
          ),
        );
      } else if (state is UpdateProfileLoading) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(context, "Updating"),
        );
      }
      return _buildScreenContent(entity);
    });
  }

  Widget _buildScreenContent(UserProfileEntity entity) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildUpdatePhotoRow(
            context,
            selectedImg: _image,
            url: entity.ppUrl!,
            onClick: () => buildPickPhotoDialog(
              context,
              gallerySource: () => getImageFromGallery(),
              cameraSource: () => getImageFromCamera(),
            ),
          ),
          buildNameEditText(
            context,
            _nameTextFieldController,
            _validateNameTextField,
          ),
          buildSaveButton(save: () => _saveChanges())
        ],
      ),
    );
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _saveChanges() {
    setState(() {
      _validateNameTextField = _nameTextFieldController.text.isEmpty;
    });
    if (!_validateNameTextField) {
      context
          .read<ProfileBloc>()
          .add(UpdateProfileEvent(_nameTextFieldController.text, _image));
    }
  }
}
