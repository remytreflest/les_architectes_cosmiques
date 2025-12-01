import 'dart:math';

class Planet {
  final String id;
  final String name;
  double metal;
  double crystal;
  double deuterium;
  double metalProduction;
  double crystalProduction;
  double deuteriumProduction;
  double energyProduction;
  double energyConsumption;
  Map<String, int> buildings;
  DateTime lastUpdate;
  bool isColonized;

  Planet({
    required this.id,
    required this.name,
    this.metal = 1000,
    this.crystal = 500,
    this.deuterium = 100,
    this.metalProduction = 0,
    this.crystalProduction = 0,
    this.deuteriumProduction = 0,
    this.energyProduction = 0,
    this.energyConsumption = 0,
    Map<String, int>? buildings,
    DateTime? lastUpdate,
    this.isColonized = false,
  }) : buildings = buildings ?? {},
       lastUpdate = lastUpdate ?? DateTime.now();

  void updateResources() {
    if (!isColonized) return;

    final now = DateTime.now();
    final seconds = now.difference(lastUpdate).inSeconds;

    final metalMineLevel = buildings['metal_mine'] ?? 0;
    final crystalMineLevel = buildings['crystal_mine'] ?? 0;
    final deuteriumSynthLevel = buildings['deuterium_synthesizer'] ?? 0;
    final solarPlantLevel = buildings['solar_plant'] ?? 0;

    energyProduction = 0;
    energyProduction += (20 * pow(1.22, solarPlantLevel)).round();

    energyConsumption = 0;
    for (int i = 1; i <= metalMineLevel; i++) {
      energyConsumption += 10 * i;
    }
    for (int i = 1; i <= crystalMineLevel; i++) {
      energyConsumption += 10 * i;
    }
    for (int i = 1; i <= deuteriumSynthLevel; i++) {
      energyConsumption += 20 * i;
    }

    double energyRatio = 1.0;
    if (energyConsumption > 0) {
      energyRatio = energyProduction >= energyConsumption
          ? 1.0
          : energyProduction / energyConsumption;
    }

    metalProduction = 10 + metalMineLevel * 100.0 * energyRatio;
    crystalProduction = 5 + crystalMineLevel * 50.0 * energyRatio;
    deuteriumProduction = deuteriumSynthLevel * 25 * energyRatio;

    metal += metalProduction * seconds;
    crystal += crystalProduction * seconds;
    deuterium += deuteriumProduction * seconds;
    lastUpdate = now;
  }

  double getEnergyRatio() {
    if (energyConsumption == 0) return 1.0;
    return energyProduction >= energyConsumption
        ? 1.0
        : energyProduction / energyConsumption;
  }

  double getAvailableEnergy() {
    return energyProduction - energyConsumption;
  }

  double calculateSolarPlantProduction(int level) {
    double total = 0;
    for (int i = 1; i <= level; i++) {
      total += 20 + (i * 5);
    }
    return total;
  }
}
