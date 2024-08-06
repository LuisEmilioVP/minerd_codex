class Visita {
  final String id;
  final String fecha;
  final String hora;
  final String motivo;
  final String comentario;
  final String fotoEvidencia;
  final String notaVoz;
  final String latitud;
  final String longitud;
  final String codigoCentro;
  final String cedulaDirector;

  Visita({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.motivo,
    required this.comentario,
    required this.fotoEvidencia,
    required this.notaVoz,
    required this.latitud,
    required this.longitud,
    required this.codigoCentro,
    required this.cedulaDirector,
  });

  factory Visita.fromJson(Map<String, dynamic> json) {
    return Visita(
      id: json['id'] ?? '',
      fecha: json['fecha'] ?? '',
      hora: json['hora'] ?? '',
      motivo: json['motivo'] ?? '',
      comentario: json['comentario'] ?? '',
      fotoEvidencia: json['foto_evidencia'] ?? '',
      notaVoz: json['nota_voz'] ?? '',
      latitud: json['latitud'] ?? '',
      longitud: json['longitud'] ?? '',
      codigoCentro: json['codigo_centro'] ?? '',
      cedulaDirector: json['cedula_director'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'hora': hora,
      'motivo': motivo,
      'comentario': comentario,
      'foto_evidencia': fotoEvidencia,
      'nota_voz': notaVoz,
      'latitud': latitud,
      'longitud': longitud,
      'codigo_centro': codigoCentro,
      'cedula_director': cedulaDirector,
    };
  }
}
