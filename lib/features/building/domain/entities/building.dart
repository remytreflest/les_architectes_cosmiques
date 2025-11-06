import 'package:les_architectes_cosmiques/features/building/domain/entities/building_data.dart';
import 'package:les_architectes_cosmiques/features/building/domain/entities/building_level_info.dart';
import 'package:les_architectes_cosmiques/features/building/domain/entities/building_params.dart';

enum BuildingType {
  mine_metal,
  mine_cristal,
  mine_deuterium,
  usine,
  laboratoire,
  centrale,
}

BuildingType buildingTypeFromJson(String value) {
  return BuildingType.values.firstWhere(
    (e) => e.toString().split('.').last == value,
    orElse: () => BuildingType.mine_metal,
  );
}

String buildingTypeToJson(BuildingType type) => type.toString().split('.').last;

// Pour simplicité : seuls les mines de métal, de cristal et de deutérium sont renseignées ici en détail.
// À poursuivre pour les autres bâtiments...

const Map<BuildingType, BuildingData> buildingDatas = {
  BuildingType.mine_metal: BuildingData(
    params: BuildingParams(
      costMetalBase: 1000,
      costMetalMult: 1.20,
      prodBase: 100,
      prodMult: 1.15,
    ),
    levels: [
      BuildingLevelInfo(
          level: 0, costMetal: 0.00, costCristal: 0.00, production: 0.00),
      BuildingLevelInfo(
          level: 1, costMetal: 1000.00, costCristal: 0.00, production: 100.00),
      BuildingLevelInfo(
          level: 2, costMetal: 1200.00, costCristal: 0.00, production: 115.00),
      BuildingLevelInfo(
          level: 3, costMetal: 1440.00, costCristal: 0.00, production: 132.25),
      BuildingLevelInfo(
          level: 4, costMetal: 1728.00, costCristal: 0.00, production: 152.09),
      BuildingLevelInfo(
          level: 5, costMetal: 2073.60, costCristal: 0.00, production: 174.90),
      BuildingLevelInfo(
          level: 6, costMetal: 2488.32, costCristal: 0.00, production: 201.14),
      BuildingLevelInfo(
          level: 7, costMetal: 2985.98, costCristal: 0.00, production: 231.31),
      BuildingLevelInfo(
          level: 8, costMetal: 3583.18, costCristal: 0.00, production: 266.00),
      BuildingLevelInfo(
          level: 9, costMetal: 4299.82, costCristal: 0.00, production: 305.90),
      BuildingLevelInfo(
          level: 10, costMetal: 5159.78, costCristal: 0.00, production: 351.78),
      BuildingLevelInfo(
          level: 11, costMetal: 6191.74, costCristal: 0.00, production: 404.55),
      BuildingLevelInfo(
          level: 12, costMetal: 7429.61, costCristal: 0.00, production: 465.23),
      BuildingLevelInfo(
          level: 13, costMetal: 8915.53, costCristal: 0.00, production: 535.01),
      BuildingLevelInfo(
          level: 14,
          costMetal: 10698.64,
          costCristal: 0.00,
          production: 615.27),
      BuildingLevelInfo(
          level: 15,
          costMetal: 12838.37,
          costCristal: 0.00,
          production: 707.06),
      BuildingLevelInfo(
          level: 16,
          costMetal: 15406.05,
          costCristal: 0.00,
          production: 813.12),
      BuildingLevelInfo(
          level: 17,
          costMetal: 18487.26,
          costCristal: 0.00,
          production: 935.09),
      BuildingLevelInfo(
          level: 18,
          costMetal: 22184.71,
          costCristal: 0.00,
          production: 1075.35),
      BuildingLevelInfo(
          level: 19,
          costMetal: 26621.65,
          costCristal: 0.00,
          production: 1236.16),
      BuildingLevelInfo(
          level: 20,
          costMetal: 31945.98,
          costCristal: 0.00,
          production: 1420.58),
      BuildingLevelInfo(
          level: 21,
          costMetal: 38335.18,
          costCristal: 0.00,
          production: 1633.67),
      BuildingLevelInfo(
          level: 22,
          costMetal: 46002.22,
          costCristal: 0.00,
          production: 1878.72),
      BuildingLevelInfo(
          level: 23,
          costMetal: 55202.66,
          costCristal: 0.00,
          production: 2160.52),
      BuildingLevelInfo(
          level: 24,
          costMetal: 66243.19,
          costCristal: 0.00,
          production: 2484.60),
      BuildingLevelInfo(
          level: 25,
          costMetal: 79491.83,
          costCristal: 0.00,
          production: 2857.29),
      BuildingLevelInfo(
          level: 26,
          costMetal: 95390.20,
          costCristal: 0.00,
          production: 3287.88),
      BuildingLevelInfo(
          level: 27,
          costMetal: 114468.24,
          costCristal: 0.00,
          production: 3785.06),
      BuildingLevelInfo(
          level: 28,
          costMetal: 137361.89,
          costCristal: 0.00,
          production: 4359.81),
      BuildingLevelInfo(
          level: 29,
          costMetal: 164834.26,
          costCristal: 0.00,
          production: 5015.77),
      BuildingLevelInfo(
          level: 30,
          costMetal: 197801.11,
          costCristal: 0.00,
          production: 5768.13),
    ],
  ),

  BuildingType.mine_cristal: BuildingData(
    params: BuildingParams(
      costMetalBase: 1500,
      costMetalMult: 1.25,
      costCristalBase: 500,
      costCristalMult: 1.22,
      prodBase: 50,
      prodMult: 1.17,
    ),
    levels: [
      BuildingLevelInfo(
          level: 0, costMetal: 0.00, costCristal: 0.00, production: 0.00),
      BuildingLevelInfo(
          level: 1, costMetal: 1500.00, costCristal: 500.00, production: 50.00),
      BuildingLevelInfo(
          level: 2, costMetal: 1875.00, costCristal: 610.00, production: 58.50),
      BuildingLevelInfo(
          level: 3, costMetal: 2343.75, costCristal: 744.20, production: 68.44),
      BuildingLevelInfo(
          level: 4, costMetal: 2929.69, costCristal: 907.00, production: 80.07),
      BuildingLevelInfo(
          level: 5,
          costMetal: 3662.11,
          costCristal: 1106.94,
          production: 93.67),
      BuildingLevelInfo(
          level: 6,
          costMetal: 4577.64,
          costCristal: 1350.45,
          production: 109.59),
      BuildingLevelInfo(
          level: 7,
          costMetal: 5722.05,
          costCristal: 1648.55,
          production: 127.95),
      BuildingLevelInfo(
          level: 8,
          costMetal: 7152.56,
          costCristal: 2010.34,
          production: 149.52),
      BuildingLevelInfo(
          level: 9,
          costMetal: 8940.70,
          costCristal: 2452.55,
          production: 174.89),
      BuildingLevelInfo(
          level: 10,
          costMetal: 11175.88,
          costCristal: 2990.12,
          production: 204.65),
      BuildingLevelInfo(
          level: 11,
          costMetal: 13969.85,
          costCristal: 3648.94,
          production: 239.01),
      BuildingLevelInfo(
          level: 12,
          costMetal: 17462.31,
          costCristal: 4456.78,
          production: 279.64),
      BuildingLevelInfo(
          level: 13,
          costMetal: 21827.89,
          costCristal: 5439.28,
          production: 327.57),
      BuildingLevelInfo(
          level: 14,
          costMetal: 27284.86,
          costCristal: 6635.92,
          production: 383.01),
      BuildingLevelInfo(
          level: 15,
          costMetal: 34106.07,
          costCristal: 8092.38,
          production: 448.13),
      BuildingLevelInfo(
          level: 16,
          costMetal: 42632.58,
          costCristal: 9860.70,
          production: 524.09),
      BuildingLevelInfo(
          level: 17,
          costMetal: 53290.73,
          costCristal: 12023.05,
          production: 612.59),
      BuildingLevelInfo(
          level: 18,
          costMetal: 66613.38,
          costCristal: 14668.13,
          production: 716.73),
      BuildingLevelInfo(
          level: 19,
          costMetal: 83266.74,
          costCristal: 17897.13,
          production: 840.57),
      BuildingLevelInfo(
          level: 20,
          costMetal: 104083.42,
          costCristal: 21824.95,
          production: 987.66),
      BuildingLevelInfo(
          level: 21,
          costMetal: 130104.28,
          costCristal: 26608.54,
          production: 1157.89),
      BuildingLevelInfo(
          level: 22,
          costMetal: 162630.35,
          costCristal: 32440.42,
          production: 1355.20),
      BuildingLevelInfo(
          level: 23,
          costMetal: 203287.94,
          costCristal: 39518.71,
          production: 1582.83),
      BuildingLevelInfo(
          level: 24,
          costMetal: 254109.92,
          costCristal: 48238.81,
          production: 1844.69),
      BuildingLevelInfo(
          level: 25,
          costMetal: 317636.15,
          costCristal: 58810.37,
          production: 2145.40),
      BuildingLevelInfo(
          level: 26,
          costMetal: 397045.19,
          costCristal: 71738.48,
          production: 2491.42),
      BuildingLevelInfo(
          level: 27,
          costMetal: 496256.49,
          costCristal: 87390.91,
          production: 2891.90),
      BuildingLevelInfo(
          level: 28,
          costMetal: 620320.61,
          costCristal: 106640.30,
          production: 3358.01),
      BuildingLevelInfo(
          level: 29,
          costMetal: 775300.76,
          costCristal: 130384.20,
          production: 3902.92),
      BuildingLevelInfo(
          level: 30,
          costMetal: 969125.95,
          costCristal: 158055.80,
          production: 4418.25),
    ],
  ),

  BuildingType.mine_deuterium: BuildingData(
    params: BuildingParams(
      costMetalBase: 5000,
      costMetalMult: 1.30,
      costCristalBase: 2000,
      costCristalMult: 1.25,
      prodBase: 10,
      prodMult: 1.20,
    ),
    levels: [
      BuildingLevelInfo(
          level: 0, costMetal: 0.00, costCristal: 0.00, production: 0.00),
      BuildingLevelInfo(
          level: 1,
          costMetal: 5000.00,
          costCristal: 2000.00,
          production: 10.00),
      BuildingLevelInfo(
          level: 2,
          costMetal: 6500.00,
          costCristal: 2500.00,
          production: 12.00),
      BuildingLevelInfo(
          level: 3,
          costMetal: 8450.00,
          costCristal: 3125.00,
          production: 14.40),
      BuildingLevelInfo(
          level: 4,
          costMetal: 10985.00,
          costCristal: 3906.00,
          production: 17.28),
      BuildingLevelInfo(
          level: 5,
          costMetal: 14280.50,
          costCristal: 4882.00,
          production: 20.74),
      BuildingLevelInfo(
          level: 6,
          costMetal: 18564.65,
          costCristal: 6103.00,
          production: 24.88),
      BuildingLevelInfo(
          level: 7,
          costMetal: 24134.04,
          costCristal: 7629.00,
          production: 29.86),
      BuildingLevelInfo(
          level: 8,
          costMetal: 31374.25,
          costCristal: 9536.00,
          production: 35.83),
      BuildingLevelInfo(
          level: 9,
          costMetal: 40786.53,
          costCristal: 11921.00,
          production: 42.9982),
      BuildingLevelInfo(
          level: 10,
          costMetal: 53022.49,
          costCristal: 14901.25,
          production: 51.5978),
      BuildingLevelInfo(
          level: 11,
          costMetal: 68929.24,
          costCristal: 18626.56,
          production: 61.9174),
      BuildingLevelInfo(
          level: 12,
          costMetal: 89607.01,
          costCristal: 23283.20,
          production: 74.3009),
      // Corrections d'anomalies de la source:
      BuildingLevelInfo(
          level: 13,
          costMetal: 116489.81,
          costCristal: 29103.99,
          production: 89.161),
      BuildingLevelInfo(
          level: 14,
          costMetal: 151336.75,
          costCristal: 36379.99,
          production: 106.99),
      BuildingLevelInfo(
          level: 15,
          costMetal: 112396.81,
          costCristal: 29103.80,
          production: 170.79),
      BuildingLevelInfo(
          level: 16,
          costMetal: 146115.85,
          costCristal: 36379.75,
          production: 205.0),
      BuildingLevelInfo(
          level: 17,
          costMetal: 189950.61,
          costCristal: 45474.69,
          production: 246.0),
      BuildingLevelInfo(
          level: 18,
          costMetal: 246935.79,
          costCristal: 56843.36,
          production: 295.2),
      BuildingLevelInfo(
          level: 19,
          costMetal: 321016.53,
          costCristal: 71054.20,
          production: 354.2),
      BuildingLevelInfo(
          level: 20,
          costMetal: 417321.49,
          costCristal: 88817.75,
          production: 425.0),
      BuildingLevelInfo(
          level: 21,
          costMetal: 542517.94,
          costCristal: 111022.19,
          production: 510.0),
      BuildingLevelInfo(
          level: 22,
          costMetal: 705273.32,
          costCristal: 138777.73,
          production: 612.0),
      BuildingLevelInfo(
          level: 23,
          costMetal: 916855.32,
          costCristal: 173472.16,
          production: 734.4),
      BuildingLevelInfo(
          level: 24,
          costMetal: 1191911.92,
          costCristal: 216840.20,
          production: 881.3),
      BuildingLevelInfo(
          level: 25,
          costMetal: 1549485.50,
          costCristal: 271050.25,
          production: 1057.6),
      BuildingLevelInfo(
          level: 26,
          costMetal: 2014331.15,
          costCristal: 338812.81,
          production: 1269.1),
      BuildingLevelInfo(
          level: 27,
          costMetal: 2618630.50,
          costCristal: 423515.99,
          production: 1522.9),
      BuildingLevelInfo(
          level: 28,
          costMetal: 3404219.65,
          costCristal: 529394.99,
          production: 1827.5),
      BuildingLevelInfo(
          level: 29,
          costMetal: 4425485.54,
          costCristal: 661743.74,
          production: 2193.0),
      BuildingLevelInfo(
          level: 30,
          costMetal: 5753131.20,
          costCristal: 827179.68,
          production: 2631.6),
    ],
  ),
  // Ajoute les autres BuildingType selon la même logique.
};

class BuildingTypeData {
  final String label;
  final bool isProduction;
  final Map<BuildingType, int> requirements;

  const BuildingTypeData({
    required this.label,
    required this.isProduction,
    this.requirements = const {},
  });
}

const Map<BuildingType, BuildingTypeData> buildingTypesData = {
  BuildingType.mine_metal: BuildingTypeData(
    label: "Mine de métal",
    isProduction: true,
    requirements: {},
  ),
  BuildingType.mine_cristal: BuildingTypeData(
    label: "Mine de cristal",
    isProduction: true,
    requirements: {},
  ),
  BuildingType.mine_deuterium: BuildingTypeData(
    label: "Mine de deutérium",
    isProduction: true,
    requirements: {},
  ),
  BuildingType.usine: BuildingTypeData(
    label: "Usine",
    isProduction: true,
    requirements: {BuildingType.mine_metal: 2},
  ),
  BuildingType.laboratoire: BuildingTypeData(
    label: "Laboratoire",
    isProduction: true,
    requirements: {BuildingType.usine: 3},
  ),
  BuildingType.centrale: BuildingTypeData(
    label: "Centrale",
    isProduction: false,
    requirements: {BuildingType.laboratoire: 2, BuildingType.mine_metal: 4},
  ),
};

class Building {
  final int id;
  final BuildingType type;
  final String planetId;
  int niveau;
  final int energieCost;

  Building({
    required this.id,
    required this.type,
    required this.planetId,
    required this.niveau,
    required this.energieCost,
  });

  bool get isProductionBuilding =>
      buildingTypesData[type]?.isProduction ?? false;

  double get productionRate {
    final data = buildingDatas[type];
    if (data == null || !isProductionBuilding) return 0;
    final buildingLevel = data.levels.firstWhere((l) => l.level == niveau);
    return buildingLevel?.production ?? 0;
  }

  Map<BuildingType, int> get requirements =>
      buildingTypesData[type]?.requirements ?? {};

  // ----------- SERIALISATION -----------
  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json['id'] as int,
        type: buildingTypeFromJson(json['type'] as String),
        planetId: json['planetId'] as String,
        niveau: json['niveau'] as int,
        energieCost: json['energieCost'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': buildingTypeToJson(type),
        'planetId': planetId,
        'niveau': niveau,
        'energieCost': energieCost,
      };

  Building copyWith({
    int? id,
    BuildingType? type,
    String? planetId,
    int? niveau,
    int? energieCost,
  }) =>
      Building(
        id: id ?? this.id,
        type: type ?? this.type,
        planetId: planetId ?? this.planetId,
        niveau: niveau ?? this.niveau,
        energieCost: energieCost ?? this.energieCost,
      );
}
