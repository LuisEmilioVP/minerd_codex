class UserForRegister {
  final String cedula;
  final String nombre;
  final String apellido;
  final String clave;
  final String correo;
  final String telefono;
  final String fechaNacimiento;

  UserForRegister({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.clave,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
  });

  factory UserForRegister.fromJson(Map<String, dynamic> json) {
    return UserForRegister(
      cedula: json['cedula'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      clave: json['clave'],
      correo: json['correo'],
      telefono: json['telefono'],
      fechaNacimiento: json['fecha_nacimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'clave': clave,
      'correo': correo,
      'telefono': telefono,
      'fecha_nacimiento': fechaNacimiento,
    };
  }
}
