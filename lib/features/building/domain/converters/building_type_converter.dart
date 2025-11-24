import 'package:drift/drift.dart';

import '../entities/building.dart';

class BuildingTypeConverter extends TypeConverter<BuildingType, String> {
  const BuildingTypeConverter();

  @override
  BuildingType fromSql(String fromDb) {
    return BuildingType.values.firstWhere(
          (e) => e.name == fromDb,
      orElse: () => BuildingType.mine_metal,
    );
  }

  @override
  String toSql(BuildingType value) => value.name;
}