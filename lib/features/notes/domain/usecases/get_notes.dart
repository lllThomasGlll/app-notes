import 'package:app_notes/features/notes/domain/entities/note.dart';
import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';

class GetNotes {
  final NotesRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call(int userId) {
    return repository.getNotesByUserId(userId);
  }
}
