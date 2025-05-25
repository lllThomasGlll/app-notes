import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/notes/data/models/note_model.dart';
import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';
import 'package:app_notes/features/notes/data/datasources/notes_local_datasource.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDatasource localDatasource;

  NotesRepositoryImpl(this.localDatasource);

  @override
  Future<List<Note>> getNotesByUserId(int userId) {
    return localDatasource.getNotesByUserId(userId);
  }

  @override
  Future<void> addNote(Note note) {
    return localDatasource.addNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> updateNote(Note note) {
    return localDatasource.updateNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> deleteNote(int noteId) {
    return localDatasource.deleteNote(noteId);
  }
}
