/// Calcule et stocke tous les bonus appliqués à une planète
class PlanetBonuses {
  // Bonus de production de ressources (multiplicateurs)
  final double metalProductionBonus;
  final double crystalProductionBonus;
  final double deuteriumProductionBonus;
  final double allResourcesBonus;

  // Bonus d'énergie
  final double energyProductionBonus;
  final double energyEfficiencyBonus;

  // Bonus de vitesse
  final double constructionSpeedBonus;
  final double researchSpeedBonus;

  // Réduction de coûts
  final double buildingCostReduction;
  final double researchCostReduction;

  const PlanetBonuses({
    this.metalProductionBonus = 0.0,
    this.crystalProductionBonus = 0.0,
    this.deuteriumProductionBonus = 0.0,
    this.allResourcesBonus = 0.0,
    this.energyProductionBonus = 0.0,
    this.energyEfficiencyBonus = 0.0,
    this.constructionSpeedBonus = 0.0,
    this.researchSpeedBonus = 0.0,
    this.buildingCostReduction = 0.0,
    this.researchCostReduction = 0.0,
  });

  /// Calcule les bonus à partir des technologies globales et politiques locales
  factory PlanetBonuses.calculate({
    required Map<String, int> globalTechnologies,
    required Map<String, int> localPolitics,
  }) {
    double metalBonus = 0.0;
    double crystalBonus = 0.0;
    double deuteriumBonus = 0.0;
    double allResourcesBonus = 0.0;
    double energyBonus = 0.0;
    double energyEfficiency = 0.0;
    double constructionSpeed = 0.0;
    double researchSpeed = 0.0;
    double buildingCostReduction = 0.0;
    double researchCostReduction = 0.0;

    // ========================================
    // TECHNOLOGIES GLOBALES
    // ========================================

    // Technologie Énergétique : +10% efficacité énergétique par niveau
    final energyTechLevel = globalTechnologies['energy_tech'] ?? 0;
    if (energyTechLevel > 0) {
      energyEfficiency += energyTechLevel * 0.10;
    }

    // ========================================
    // POLITIQUES LOCALES (PAR PLANÈTE)
    // ========================================

    // ☭ Communisme Spatial : +15% production de métal
    if ((localPolitics['communism'] ?? 0) > 0) {
      metalBonus += 0.15;
    }

    // 💰 Capitalisme Galactique : -10% coûts de construction
    if ((localPolitics['capitalism'] ?? 0) > 0) {
      buildingCostReduction += 0.10;
    }

    // 🏢 Action de Trump : +20% cristal, +10% énergie
    if ((localPolitics['trump_action'] ?? 0) > 0) {
      crystalBonus += 0.20;
      energyBonus += 0.10;
    }

    // 🥖 Révolution Française : +25% vitesse de recherche
    if ((localPolitics['french_revolution'] ?? 0) > 0) {
      researchSpeed += 0.25;
    }

    // 🍕 Pizza Party Universelle : +10% toutes les ressources
    if ((localPolitics['pizza_party'] ?? 0) > 0) {
      allResourcesBonus += 0.10;
    }

    // 😂 Memes Intergalactiques : -15% coûts de recherche
    if ((localPolitics['intergalactic_memes'] ?? 0) > 0) {
      researchCostReduction += 0.15;
    }

    // ☕ Café Spatial Premium : +30% vitesse de construction
    if ((localPolitics['space_coffee'] ?? 0) > 0) {
      constructionSpeed += 0.30;
    }

    // 👽 Alliance Extraterrestre : +50% production d'énergie
    if ((localPolitics['alien_alliance'] ?? 0) > 0) {
      energyBonus += 0.50;
    }

    return PlanetBonuses(
      metalProductionBonus: metalBonus,
      crystalProductionBonus: crystalBonus,
      deuteriumProductionBonus: deuteriumBonus,
      allResourcesBonus: allResourcesBonus,
      energyProductionBonus: energyBonus,
      energyEfficiencyBonus: energyEfficiency,
      constructionSpeedBonus: constructionSpeed,
      researchSpeedBonus: researchSpeed,
      buildingCostReduction: buildingCostReduction,
      researchCostReduction: researchCostReduction,
    );
  }

  /// Applique le multiplicateur total de métal (bonus spécifique + bonus global)
  double getMetalMultiplier() {
    return 1.0 + metalProductionBonus + allResourcesBonus;
  }

  /// Applique le multiplicateur total de cristal
  double getCrystalMultiplier() {
    return 1.0 + crystalProductionBonus + allResourcesBonus;
  }

  /// Applique le multiplicateur total de deutérium
  double getDeuteriumMultiplier() {
    return 1.0 + deuteriumProductionBonus + allResourcesBonus;
  }

  /// Applique le multiplicateur total d'énergie
  double getEnergyMultiplier() {
    return 1.0 + energyProductionBonus;
  }

  /// Calcule le coût réduit d'un bâtiment
  int getReducedBuildingCost(int baseCost) {
    return (baseCost * (1.0 - buildingCostReduction)).round();
  }

  /// Calcule le coût réduit d'une recherche
  int getReducedResearchCost(int baseCost) {
    return (baseCost * (1.0 - researchCostReduction)).round();
  }

  @override
  String toString() {
    return 'PlanetBonuses(\n'
        '  Metal: +${(metalProductionBonus * 100).toStringAsFixed(0)}%\n'
        '  Crystal: +${(crystalProductionBonus * 100).toStringAsFixed(0)}%\n'
        '  Deuterium: +${(deuteriumProductionBonus * 100).toStringAsFixed(0)}%\n'
        '  All Resources: +${(allResourcesBonus * 100).toStringAsFixed(0)}%\n'
        '  Energy: +${(energyProductionBonus * 100).toStringAsFixed(0)}%\n'
        '  Building Cost: -${(buildingCostReduction * 100).toStringAsFixed(0)}%\n'
        ')';
  }
}
