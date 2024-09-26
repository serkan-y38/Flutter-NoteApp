import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/common/snackbac_helper.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:note_app/features/note/presentation/bloc/note_event.dart';
import 'package:note_app/features/note/presentation/bloc/note_state.dart';
import '../../../../../core/navigation/route_navigation.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateNoteScreen();
}

class _CreateNoteScreen extends State<CreateNoteScreen> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _bodyTextEditingController;

  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController();
    _bodyTextEditingController = TextEditingController();
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
        if (didPop) _navigateToNotes();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create note"),
          leading: IconButton(
            onPressed: () => _navigateToNotes(),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
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
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is InsertNoteSuccess) {
        context.read<NoteBloc>().add(InitialNoteEvent());
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(context, "Saved successfully."),
        );
        _navigateToNotes();
      } else if (state is InsertNoteError) {
        context.read<NoteBloc>().add(InitialNoteEvent());
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(context, state.e.toString()),
        );
      } else if (state is InsertNoteLoading) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showBasicSnackBar(context, "Saving..."),
        );
      }
      return _buildScreenContent();
    });
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
    context.read<NoteBloc>().add(InsertNoteEvent(
          NoteEntity(
            null,
            _titleTextEditingController.text,
            _bodyTextEditingController.text,
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          ),
        ));
  }

  void _navigateToNotes() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.pushReplacementNamed(
        context,
        RouteNavigation.notesScreen,
      ),
    );
  }
}
