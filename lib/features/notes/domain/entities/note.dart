class Note {
  final int? id;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final int userId;
  final int tipoId;

  Note({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.userId,
    required this.tipoId,
  });
}
