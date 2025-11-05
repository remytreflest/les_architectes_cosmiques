class Resource {
  final int id;
  final int planetId;
  final String type;
  final double quantity;

  const Resource({
    required this.id,
    required this.planetId,
    required this.type,
    required this.quantity,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'] as int,
      planetId: json['planetId'] as int,
      type: json['type'] as String,
      quantity: (json['quantity'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'planetId': planetId,
        'type': type,
        'quantity': quantity,
      };

  Resource copyWith({
    int? id,
    int? planetId,
    String? type,
    double? quantity,
  }) {
    return Resource(
      id: id ?? this.id,
      planetId: planetId ?? this.planetId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
    );
  }
}
