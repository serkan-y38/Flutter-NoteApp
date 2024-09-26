import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/navigation/route_navigation.dart';
import 'package:note_app/features/note/domain/entity/note_entity.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:note_app/features/note/presentation/bloc/note_event.dart';
import 'package:note_app/features/note/presentation/bloc/note_state.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NotesScreen();
}

class _NotesScreen extends State<NotesScreen> {
  late SearchController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _searchController = SearchController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    super.initState();

    context.read<NoteBloc>().add(GetInitialNotesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      log("end of list");
      context.read<NoteBloc>().add(LoadMoreNotesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(
          context,
          RouteNavigation.createNoteScreen,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchView(),
        _buildNotesBloc(),
      ],
    );
  }

  Widget _buildSearchView() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchAnchor(
          searchController: _searchController,
          viewLeading: IconButton(
              onPressed: () {
                _searchController.clear();
                _searchController.closeView("");
                _searchController.clearComposing();
              },
              icon: const Icon(Icons.arrow_back)),
          viewHintText: "Search",
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              hintText: "Search",
              focusNode: FocusNode(canRequestFocus: false),
              autoFocus: false,
              controller: _searchController,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                _searchController.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          RouteNavigation.profileDetailsScreen,
                        ),
                    icon: const Icon(Icons.person))
              ],
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    _searchController.closeView(item);
                  });
                },
              );
            });
          }),
    );
  }

  Widget _buildNotesBloc() {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is GetInitialNotesSuccess || state is LoadMoreNoteSuccess) {
        return _buildNoteList(state.notes!);
      } else if (state is GetNotesError) {
        return const Icon(Icons.error);
      } else if (state is GetNotesLoading) {
        return const CircularProgressIndicator();
      }
      return const SizedBox();
    });
  }

  Widget _buildNoteList(List<NoteEntity> notes) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: notes.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(notes[index].title!),
              leading: const Icon(Icons.edit_note_sharp),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                RouteNavigation.noteDetailsScreen,
                arguments: (notes[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
