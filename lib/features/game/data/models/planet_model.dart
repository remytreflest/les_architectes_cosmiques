import '../../domain/entities/planet.dart';

class PlanetModel extends Planet {
  PlanetModel({
    required String id,
    required String name,
    double metal = 1000,
    double crystal = 500,
    double deuterium = 100,
    double metalProduction = 0,
    double crystalProduction = 0,
    double deuteriumProduction = 0,
    double energyProduction = 0,
    double energyConsumption = 0,
    Map<String, int>? buildings,
    DateTime? lastUpdate,
    bool isColonized = false,
  }) : super(
         id: id,
         name: name,
         metal: metal,
         crystal: crystal,
         deuterium: deuterium,
         metalProduction: metalProduction,
         crystalProduction: crystalProduction,
         deuteriumProduction: deuteriumProduction,
         energyProduction: energyProduction,
         energyConsumption: energyConsumption,
         buildings: buildings,
         lastUpdate: lastUpdate,
         isColonized: isColonized,
       );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'metal': metal,
    'crystal': crystal,
    'deuterium': deuterium,
    'metalProduction': metalProduction,
    'crystalProduction': crystalProduction,
    'deuteriumProduction': deuteriumProduction,
    'energyProduction': energyProduction,
    'energyConsumption': energyConsumption,
    'buildings': buildings,
    'lastUpdate': lastUpdate.toIso8601String(),
    'isColonized': isColonized,
  };

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
    id: json['id'],
    name: json['name'],
    metal: json['metal']?.toDouble() ?? 1000,
    crystal: json['crystal']?.toDouble() ?? 500,
    deuterium: json['deuterium']?.toDouble() ?? 100,
    metalProduction: json['metalProduction']?.toDouble() ?? 0,
    crystalProduction: json['crystalProduction']?.toDouble() ?? 0,
    deuteriumProduction: json['deuteriumProduction']?.toDouble() ?? 0,
    energyProduction: json['energyProduction']?.toDouble() ?? 0,
    energyConsumption: json['energyConsumption']?.toDouble() ?? 0,
    buildings: Map<String, int>.from(json['buildings'] ?? {}),
    lastUpdate: DateTime.parse(json['lastUpdate']),
    isColonized: json['isColonized'] ?? false,
  );

  factory PlanetModel.fromEntity(Planet planet) => PlanetModel(
    id: planet.id,
    name: planet.name,
    metal: planet.metal,
    crystal: planet.crystal,
    deuterium: planet.deuterium,
    metalProduction: planet.metalProduction,
    crystalProduction: planet.crystalProduction,
    deuteriumProduction: planet.deuteriumProduction,
    energyProduction: planet.energyProduction,
    energyConsumption: planet.energyConsumption,
    buildings: planet.buildings,
    lastUpdate: planet.lastUpdate,
    isColonized: planet.isColonized,
  );
}
