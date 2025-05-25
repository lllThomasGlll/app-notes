import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/auth/presentation/bloc/barrel_auth_bloc.dart';
import 'package:app_notes/features/notes/presentation/bloc/barrel_notes_bloc.dart';
import 'package:app_notes/features/notes/presentation/screens/settings_screen.dart';
import 'package:app_notes/features/notes/presentation/screens/note_edit_screen.dart';
import 'package:app_notes/features/notes/presentation/screens/note_save_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final authState = context.read<AuthBloc>().state;
      if (authState is Authenticated) {
        final userId = authState.user.id;
        context.read<NotesBloc>().add(LoadNotes(userId));
      }
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notes', style: TextStyle(color: Colors.white)),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.gear, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: [FilterButton(label: 'Todo', selected: true)]),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesLoaded && state.notes.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NoteEditScreen(note: note),
                            ),
                          );
                        },
                        child: NoteCard(note: note),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.book,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No hay notas aún',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteSaveScreen()),
          );
        },
        child: const Icon(FontAwesomeIcons.plus, color: Colors.black),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          note.titulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          note.descripcion,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          _formatTime(note.fecha),
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final suffix = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dateTime.minute.toString().padLeft(2, '0')} $suffix';
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool selected;

  const FilterButton({super.key, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.grey[800] : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
