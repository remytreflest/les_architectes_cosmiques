import 'package:les_architectes_cosmiques/features/building/domain/entities/building.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/planet_name.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/ressource.dart';

class Planet {
  final int id;
  final int userId;
  final PlanetName name;
  final String? politicalRegime;
  final List<Resource> resources;
  final bool isColonized;
  final List<Building> buildings;

  const Planet({
    required this.id,
    required this.userId,
    required this.name,
    this.politicalRegime,
    this.resources = const [],
    this.isColonized = false,
    this.buildings = const [],
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        id: json['id'] as int,
        userId: json['userId'] as int,
        name: json['name'] as PlanetName,
        politicalRegime: json['politicalRegime'] as String?,
        resources: (json['resources'] as List<dynamic>? ?? [])
            .map((res) => Resource.fromJson(res as Map<String, dynamic>))
            .toList(),
        isColonized: json['isColonized'] as bool? ?? false,
        buildings: (json['buildings'] as List<dynamic>? ?? [])
            .map((b) => Building.fromJson(b as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'politicalRegime': politicalRegime,
        'resources': resources.map((r) => r.toJson()).toList(),
        'isColonized': isColonized,
        'buildings': buildings.map((b) => b.toJson()).toList(),
      };

  Planet copyWith({
    int? id,
    int? userId,
      PlanetName? name,
    String? politicalRegime,
    List<Resource>? resources,
    bool? isColonized,
    List<Building>? buildings,
  }) =>
      Planet(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        politicalRegime: politicalRegime ?? this.politicalRegime,
        resources: resources ?? this.resources,
        isColonized: isColonized ?? this.isColonized,
        buildings: buildings ?? this.buildings,
      );
}


