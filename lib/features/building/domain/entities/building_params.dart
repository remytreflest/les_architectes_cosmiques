class BuildingParams {
  final double? costMetalBase;
  final double? costMetalMult;
  final double? costCristalBase;
  final double? costCristalMult;
  final double prodBase;
  final double prodMult;

  const BuildingParams({
    this.costMetalBase,
    this.costMetalMult,
    this.costCristalBase,
    this.costCristalMult,
    required this.prodBase,
    required this.prodMult,
  });
}
