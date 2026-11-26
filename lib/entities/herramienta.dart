class Herramienta {
  final String id;
  final String nombre;
  final String desc;
  final int cantidad;
  final String categoria;
  final String ubicacion;
  final String foto;

  Herramienta({
    required this.id,
    required this.nombre,
    required this.desc,
    required this.cantidad,
    required this.categoria,
    required this.ubicacion,
    required this.foto,
  });

  Herramienta copyWith({
    String? id,
    String? nombre,
    String? desc,
    int? cantidad,
    String? categoria,
    String? ubicacion,
    String? foto,
  }) {
    return Herramienta(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      desc: desc ?? this.desc,
      cantidad: cantidad ?? this.cantidad,
      categoria: categoria ?? this.categoria,
      ubicacion: ubicacion ?? this.ubicacion,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'desc': desc,
      'cantidad': cantidad,
      'categoria': categoria,
      'ubicacion': ubicacion,
      'foto': foto,
    };
  }

  factory Herramienta.fromMap(String id, Map<String, dynamic> map) {
    return Herramienta(
      id: id,
      nombre: map['nombre'] ?? '',
      desc: map['desc'] ?? '',
      cantidad: (map['cantidad'] as num?)?.toInt() ?? 0,
      categoria: map['categoria'] ?? 'General',
      ubicacion: map['ubicacion'] ?? 'Taller',
      foto: map['foto'] ?? '',
    );
  }
}