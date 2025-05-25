import 'package:app_notes/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotesByUserId(int userId);
  Future<void> addNote(Note note);
  Future<void> deleteNote(int noteId);
  Future<void> updateNote(Note note);
}
