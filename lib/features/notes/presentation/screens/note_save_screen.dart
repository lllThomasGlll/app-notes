import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_notes/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_notes/features/notes/presentation/bloc/barrel_notes_bloc.dart';

class NoteSaveScreen extends StatefulWidget {
  const NoteSaveScreen({super.key});

  @override
  State<NoteSaveScreen> createState() => _NoteSaveScreenState();
}

class _NoteSaveScreenState extends State<NoteSaveScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      final userId = authState.user.id;

      final newNote = Note(
        titulo: title,
        descripcion: content,
        fecha: DateTime.now(),
        userId: userId,
        tipoId: 1,
      );

      context.read<NotesBloc>().add(AddNoteEvent(newNote));

      Navigator.pushReplacementNamed(context, '/notes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat("d 'de' MMMM", 'es_ES').format(now);
    final formattedTime = TimeOfDay.now().format(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.check, color: Colors.white),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white, fontSize: 24),
              decoration: InputDecoration(
                hintText: 'Titulo',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                filled: false,
              ),
            ),

            Text(
              '$formattedDate $formattedTime',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white, fontSize: 16),
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Iniciar escritura',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
