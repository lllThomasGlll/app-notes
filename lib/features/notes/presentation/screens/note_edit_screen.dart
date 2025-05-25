import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/notes/presentation/bloc/barrel_notes_bloc.dart';

class NoteEditScreen extends StatefulWidget {
  final Note note;

  const NoteEditScreen({super.key, required this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.titulo);
    _contentController = TextEditingController(text: widget.note.descripcion);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _deleteNote() {
    context.read<NotesBloc>().add(DeleteNoteEvent(widget.note.id!));
    Navigator.pushReplacementNamed(context, '/notes');
  }

  void _updateNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    final updatedNote = Note(
      id: widget.note.id,
      titulo: title,
      descripcion: content,
      fecha: DateTime.now(),
      userId: widget.note.userId,
      tipoId: widget.note.tipoId,
    );

    context.read<NotesBloc>().add(UpdateNoteEvent(updatedNote));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      "d 'de' MMMM",
      'es_ES',
    ).format(widget.note.fecha);
    final formattedTime = TimeOfDay.fromDateTime(
      widget.note.fecha,
    ).format(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.trash),
            onPressed: _deleteNote,
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: _updateNote,
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
                hintText: 'Título',
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
