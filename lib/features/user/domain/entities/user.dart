class User {
  final int id;
  final String name;
  final List<int>? planetIds;

  const User({
    required this.id,
    required this.name,
    this.planetIds = const [0, 1, 2, 3, 4, 5, 6, 7],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      planetIds:
          (json['planetIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'planetIds': planetIds,
    };
  }

  User copyWith({
    int? id,
    String? name,
    List<int>? planetIds,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      planetIds: planetIds ?? this.planetIds,
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, planetIds: $planetIds)';
}
