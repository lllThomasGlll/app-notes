import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';

class UpdateNote {
  final NotesRepository repository;

  UpdateNote(this.repository);

  Future<void> call(Note note) {
    return repository.updateNote(note);
  }
}
