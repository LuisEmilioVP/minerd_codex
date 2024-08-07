class CentroEducativo {
  final String idx;
  final String codigo;
  final String nombre;
  final String coordenadas;
  final String distrito;
  final String regional;
  final String dDmunicipal;

  CentroEducativo({
    required this.idx,
    required this.codigo,
    required this.nombre,
    required this.coordenadas,
    required this.distrito,
    required this.regional,
    required this.dDmunicipal,
  });

  factory CentroEducativo.fromJson(Map<String, dynamic> json) {
    return CentroEducativo(
      idx: json['idx'] ?? '',
      codigo: json['codigo'] ?? '',
      nombre: json['nombre'] ?? '',
      coordenadas: json['coordenadas'] ?? '',
      distrito: json['distrito'] ?? '',
      regional: json['regional'] ?? '',
      dDmunicipal: json['d_dmunicipal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'codigo': codigo,
      'nombre': nombre,
      'coordenadas': coordenadas,
      'distrito': distrito,
      'regional': regional,
      'd_dmunicipal': dDmunicipal,
    };
  }
}
