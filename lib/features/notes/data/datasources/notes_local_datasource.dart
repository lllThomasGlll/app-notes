import 'package:flutter/foundation.dart';

import 'package:app_notes/core/database/database_helper.dart';
import 'package:app_notes/features/notes/data/models/note_model.dart';

abstract class NotesLocalDatasource {
  Future<List<NoteModel>> getNotesByUserId(int userId);
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(int noteId);
}

class NotesLocalDatasourceImpl implements NotesLocalDatasource {
  final DatabaseHelper databaseHelper;

  NotesLocalDatasourceImpl(this.databaseHelper);

  @override
  Future<List<NoteModel>> getNotesByUserId(int userId) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'notas',
      where: 'usuario_id = ?',
      whereArgs: [userId],
    );

    if (kDebugMode) {
      print('Notas crudas desde BD: $maps');
    }
    return maps.map((map) => NoteModel.fromJson(map)).toList();
  }

  @override
  Future<void> addNote(NoteModel note) async {
    final db = await databaseHelper.database;
    await db.insert('notas', note.toJson());
    if (kDebugMode) {
      print(
        'Nota insertada con ID: ${note.id}, Título: ${note.titulo}, Descripción: ${note.descripcion}, Fecha: ${note.fecha}, User ID: ${note.userId}, Tipo ID: ${note.tipoId}',
      );
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final db = await databaseHelper.database;
    await db.update(
      'notas',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(int noteId) async {
    final db = await databaseHelper.database;
    await db.delete('notas', where: 'id = ?', whereArgs: [noteId]);
  }
}
