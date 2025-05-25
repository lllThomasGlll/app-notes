import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_notes/features/notes/domain/usecases/add_note.dart';
import 'package:app_notes/features/notes/domain/usecases/get_notes.dart';
import 'package:app_notes/features/notes/domain/usecases/delete_note.dart';
import 'package:app_notes/features/notes/domain/usecases/update_note.dart';
import 'package:app_notes/features/notes/presentation/bloc/notes_event.dart';
import 'package:app_notes/features/notes/presentation/bloc/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotes getNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NotesBloc({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    final notes = await getNotes(event.userId);
    emit(NotesLoaded(notes));
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    await addNote(event.note);
    add(LoadNotes(event.note.userId));
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await updateNote(event.note);
    add(LoadNotes(event.note.userId));
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await deleteNote(event.noteId);
  }
}
