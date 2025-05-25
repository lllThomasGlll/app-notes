import 'package:app_notes/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    super.id,
    required super.titulo,
    required super.descripcion,
    required super.fecha,
    required super.userId,
    required super.tipoId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] != null ? json['id'] as int : null,
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
      userId: json['usuario_id'],
      tipoId: json['tipo_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'usuario_id': userId,
      'tipo_id': tipoId,
    };
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      titulo: note.titulo,
      descripcion: note.descripcion,
      fecha: note.fecha,
      userId: note.userId,
      tipoId: note.tipoId,
    );
  }
}
