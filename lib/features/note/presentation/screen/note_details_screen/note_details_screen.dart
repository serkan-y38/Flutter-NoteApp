import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:note_app/features/note/presentation/bloc/note_state.dart';
import '../../../../../core/common/snackbac_helper.dart';
import '../../../../../core/navigation/route_navigation.dart';
import '../../bloc/note_event.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key, required this.noteEntity});

  final NoteEntity noteEntity;

  @override
  State<StatefulWidget> createState() => _NoteDetailsScreen();
}

class _NoteDetailsScreen extends State<NoteDetailsScreen> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _bodyTextEditingController;

  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController()
      ..text = widget.noteEntity.title ?? "";
    _bodyTextEditingController = TextEditingController()
      ..text = widget.noteEntity.text ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextEditingController.dispose();
    _bodyTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushReplacementNamed(
              context,
              RouteNavigation.notesScreen,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.pushReplacementNamed(
                context,
                RouteNavigation.notesScreen,
              ),
            ),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () => _delete(),
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () => _save(),
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is UpdateNoteSuccess) {
          context.read<NoteBloc>().add(InitialNoteEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, "Saved successfully."),
          );
        } else if (state is UpdateNoteError) {
          context.read<NoteBloc>().add(InitialNoteEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, state.e.toString()),
          );
        } else if (state is UpdateNoteLoading) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, "Saving..."),
          );
        } else if (state is DeleteNoteSuccess) {
          context.read<NoteBloc>().add(InitialNoteEvent());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showBasicSnackBar(context, "Deleted successfully.");
            Navigator.pushReplacementNamed(
              context,
              RouteNavigation.notesScreen,
            );
          });
        } else if (state is DeleteNoteError) {
          context.read<NoteBloc>().add(InitialNoteEvent());
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, state.e.toString()),
          );
        } else if (state is DeleteNoteLoading) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showBasicSnackBar(context, "Deleting..."),
          );
        }
        return _buildScreenContent();
      },
    );
  }

  Widget _buildScreenContent() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: _titleTextEditingController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              labelText: "Title",
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _bodyTextEditingController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              labelText: "Text",
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: const UnderlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  void _save() {
    context.read<NoteBloc>().add(UpdateNoteEvent(NoteEntity(
          widget.noteEntity.id,
          _titleTextEditingController.text,
          _bodyTextEditingController.text,
          widget.noteEntity.createdDate,
        )));
  }

  void _delete() {
    context.read<NoteBloc>().add(DeleteNoteEvent(widget.noteEntity.id!));
  }
}
