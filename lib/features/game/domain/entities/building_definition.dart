import 'dart:math';

class BuildingDefinition {
  final String id;
  final String name;
  final String description;
  final int metalCost;
  final int crystalCost;
  final int deuteriumCost;
  final List<String> requirements;

  const BuildingDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.metalCost,
    required this.crystalCost,
    required this.deuteriumCost,
    this.requirements = const [],
  });

  int getCost(int level, String resource) {
    final baseCost = resource == 'metal'
        ? metalCost
        : resource == 'crystal'
        ? crystalCost
        : deuteriumCost;

    return (baseCost * pow(1.5, level)).round();
  }
}
