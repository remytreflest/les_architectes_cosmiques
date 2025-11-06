import 'building_level_info.dart';
import 'building_params.dart';

class BuildingData {
  final BuildingParams params;
  final List<BuildingLevelInfo> levels;

  const BuildingData({
    required this.params,
    required this.levels,
  });
}
