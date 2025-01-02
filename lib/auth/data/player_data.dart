class PlayerData {
  final String? name;
  final int? level;
  final int? topScore;

  const PlayerData({
    required this.name,
    required this.level,
    required this.topScore,
  });

  factory PlayerData.fromMap(Map<String, dynamic> data) {
    return PlayerData(name: data['name'], level: data['level'], topScore: data['topScore']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'topScore': topScore,
    };
  }


}