import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';

class AddNote {
  final NotesRepository repository;

  AddNote(this.repository);

  Future<void> call(Note note) {
    return repository.addNote(note);
  }
}
