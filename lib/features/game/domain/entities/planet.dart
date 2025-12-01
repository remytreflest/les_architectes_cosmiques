// ============================================================================
// features/game/domain/entities/planet.dart (REFACTORISÉE)
// ============================================================================
import 'dart:math';

import 'planet_bonuses.dart';

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
  Map<String, int> diplomacyTechs; // ← NOUVEAU : Politiques par planète
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
    Map<String, int>? diplomacyTechs, // ← NOUVEAU
    DateTime? lastUpdate,
    this.isColonized = false,
  }) : buildings = buildings ?? {},
       diplomacyTechs = diplomacyTechs ?? {}, // ← NOUVEAU
       lastUpdate = lastUpdate ?? DateTime.now();

  /// Met à jour les ressources en prenant en compte les technologies globales
  void updateResources({Map<String, int>? globalTechnologies}) {
    if (!isColonized) return;

    final now = DateTime.now();
    final seconds = now.difference(lastUpdate).inSeconds;

    // Calculer les bonus (technologies globales + politiques locales)
    PlanetBonuses bonuses = PlanetBonuses.calculate(
      globalTechnologies: globalTechnologies ?? {},
      localPolitics: diplomacyTechs,
    );

    // Niveaux des bâtiments
    final metalMineLevel = buildings['metal_mine'] ?? 0;
    final crystalMineLevel = buildings['crystal_mine'] ?? 0;
    final deuteriumSynthLevel = buildings['deuterium_synthesizer'] ?? 0;
    final solarPlantLevel = buildings['solar_plant'] ?? 0;

    // ========================================
    // PRODUCTION D'ÉNERGIE (avec bonus)
    // ========================================
    energyProduction = _calculateEnergyProduction(
      solarPlantLevel,

      ((globalTechnologies == null ? 0 : globalTechnologies['energy_tech'])! *
          0.1),
    );

    // ========================================
    // CONSOMMATION D'ÉNERGIE
    // ========================================
    energyConsumption = _calculateEnergyConsumption(
      metalMineLevel,
      crystalMineLevel,
      deuteriumSynthLevel,
    );

    // ========================================
    // RATIO D'ÉNERGIE
    // ========================================
    double energyRatio = 1.0;
    if (energyConsumption > 0) {
      energyRatio = energyProduction >= energyConsumption
          ? 1.0
          : energyProduction / energyConsumption;
    }

    // Appliquer le bonus d'efficacité énergétique
    final effectiveEnergyRatio = min(
      1.0,
      energyRatio * (1.0 + bonuses.energyEfficiencyBonus),
    );

    // ========================================
    // PRODUCTION DE RESSOURCES (avec bonus)
    // ========================================
    metalProduction = _calculateMetalProduction(
      metalMineLevel,
      effectiveEnergyRatio,
      bonuses.getMetalMultiplier(),
    );

    crystalProduction = _calculateCrystalProduction(
      crystalMineLevel,
      effectiveEnergyRatio,
      bonuses.getCrystalMultiplier(),
    );

    deuteriumProduction = _calculateDeuteriumProduction(
      deuteriumSynthLevel,
      effectiveEnergyRatio,
      bonuses.getDeuteriumMultiplier(),
    );

    // ========================================
    // APPLIQUER AU TEMPS ÉCOULÉ
    // ========================================
    metal += metalProduction * seconds;
    crystal += crystalProduction * seconds;
    deuterium += deuteriumProduction * seconds;
    lastUpdate = now;
  }

  // ========================================
  // MÉTHODES PRIVÉES DE CALCUL
  // ========================================

  double _calculateEnergyProduction(int solarPlantLevel, double multiplier) {
    if (solarPlantLevel == 0) return 0;
    // Formule : 20 × 1.22^niveau × multiplicateur de bonus
    return (20 * pow(1.22, solarPlantLevel) * (1 + multiplier)).roundToDouble();
  }

  double _calculateEnergyConsumption(
    int metalMineLevel,
    int crystalMineLevel,
    int deuteriumSynthLevel,
  ) {
    double consumption = 0;

    // Consommation progressive des mines
    for (int i = 1; i <= metalMineLevel; i++) {
      consumption += 10 * i;
    }
    for (int i = 1; i <= crystalMineLevel; i++) {
      consumption += 10 * i;
    }
    for (int i = 1; i <= deuteriumSynthLevel; i++) {
      consumption += 20 * i;
    }

    return consumption;
  }

  double _calculateMetalProduction(
    int mineLevel,
    double energyRatio,
    double multiplier,
  ) {
    // Production de base : 10 + niveau × 100
    final baseProduction = 10 + (mineLevel * 1000.0);
    return baseProduction * energyRatio * multiplier;
  }

  double _calculateCrystalProduction(
    int mineLevel,
    double energyRatio,
    double multiplier,
  ) {
    // Production de base : 5 + niveau × 50
    final baseProduction = 5 + (mineLevel * 500.0);
    return baseProduction * energyRatio * multiplier;
  }

  double _calculateDeuteriumProduction(
    int synthLevel,
    double energyRatio,
    double multiplier,
  ) {
    // Production de base : niveau × 25
    final baseProduction = synthLevel * 250.0;
    return baseProduction * energyRatio * multiplier;
  }

  // ========================================
  // MÉTHODES PUBLIQUES UTILITAIRES
  // ========================================

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
    // Utilisé pour l'affichage UI
    return (20 * pow(1.22, level)).roundToDouble();
  }

  /// Calcule les bonus actifs sur cette planète
  PlanetBonuses getBonuses({Map<String, int>? globalTechnologies}) {
    return PlanetBonuses.calculate(
      globalTechnologies: globalTechnologies ?? {},
      localPolitics: diplomacyTechs,
    );
  }

  /// Vérifie si une politique est active
  bool hasPolitics(String politicsId) {
    return (diplomacyTechs[politicsId] ?? 0) > 0;
  }

  /// Active une politique sur cette planète
  void adoptPolitics(String politicsId) {
    diplomacyTechs[politicsId] = 1;
  }
}
