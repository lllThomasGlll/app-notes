import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';

class DeleteNote {
  final NotesRepository repository;

  DeleteNote(this.repository);

  Future<void> call(int noteId) {
    return repository.deleteNote(noteId);
  }
}
