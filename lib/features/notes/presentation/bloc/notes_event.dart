import 'package:equatable/equatable.dart';

import 'package:app_notes/features/notes/domain/entities/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesEvent {
  final int userId;

  const LoadNotes(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddNoteEvent extends NotesEvent {
  final Note note;

  const AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;

  const UpdateNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final int noteId;

  const DeleteNoteEvent(this.noteId);

  @override
  List<Object> get props => [noteId];
}

class LoadNoteById extends NotesEvent {
  final int noteId;
  const LoadNoteById(this.noteId);
}
