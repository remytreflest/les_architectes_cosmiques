import 'package:les_architectes_cosmiques/features/planet/domain/entities/ressource.dart';

class Planet {
  final int id;
  final int userId;
  final String name;
  final String? politicalRegime;
  final List<Resource> resources;
  final bool isColonized; // Nouvelle propriété

  const Planet({
    required this.id,
    required this.userId,
    required this.name,
    this.politicalRegime,
    this.resources = const [],
    this.isColonized = false, // valeur par défaut
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        id: json['id'] as int,
        userId: json['userId'] as int,
        name: json['name'] as String,
        politicalRegime: json['politicalRegime'] as String?,
        resources: (json['resources'] as List<dynamic>? ?? [])
            .map((res) => Resource.fromJson(res as Map<String, dynamic>))
            .toList(),
        isColonized: json['isColonized'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'politicalRegime': politicalRegime,
        'resources': resources.map((r) => r.toJson()).toList(),
        'isColonized': isColonized,
      };

  Planet copyWith({
    int? id,
    int? userId,
    String? name,
    String? politicalRegime,
    List<Resource>? resources,
    bool? isColonized,
  }) =>
      Planet(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        politicalRegime: politicalRegime ?? this.politicalRegime,
        resources: resources ?? this.resources,
        isColonized: isColonized ?? this.isColonized,
      );
}
