class User {
  final String id;
  final String ci;
  final String apellido;
  final String name;
  final String fn; // Podrías usar DateTime si prefieres
  final int edad;
  final String ec;
  final bool isPublished;

  User({
    required this.id,
    required this.ci,
    required this.apellido,
    required this.name,
    required this.fn,
    required this.edad,
    required this.ec,
    required this.isPublished,
  });

  // Getter auxiliar
  bool get done => isPublished;

  // copyWith
  User copyWith({
    String? id,
    String? ci,
    String? apellido,
    String? name,
    String? fn,
    int? edad,
    String? ec,
    bool? isPublished,
  }) {
    return User(
      id: id ?? this.id,
      ci: ci ?? this.ci,
      apellido: apellido ?? this.apellido,
      name: name ?? this.name,
      fn: fn ?? this.fn,
      edad: edad ?? this.edad,
      ec: ec ?? this.ec,
      isPublished: isPublished ?? this.isPublished,
    );
  }

  // ✅ fromJson
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      ci: json['ci'] ?? '',
      apellido: json['apellido'] ?? '',
      name: json['name'] ?? '',
      fn: json['fn'] ?? '',
      edad: json['edad'] is int ? json['edad'] : int.tryParse(json['edad'].toString()) ?? 0,
      ec: json['ec'] ?? '',
      isPublished: json['isPublished'] ?? false,
    );
  }

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ci': ci,
      'apellido': apellido,
      'name': name,
      'fn': fn,
      'edad': edad,
      'ec': ec,
      'isPublished': isPublished,
    };
  }
}
