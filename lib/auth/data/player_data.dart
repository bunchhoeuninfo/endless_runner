class PlayerData {
  String playerName;
  int level;
  int topScore;
  String gender;
  DateTime dateOfBirth;
  String? profileImgPath;

  PlayerData({
    required this.playerName,
    required this.level,
    required this.topScore,
    required this.gender,
    required this.dateOfBirth,
    required this.profileImgPath,
  });

  factory PlayerData.fromMap(Map<String, dynamic> data) {
    return PlayerData(playerName: data['playerName'], level: data['level'], topScore: data['topScore'],
    gender: data['gender'], dateOfBirth: DateTime.parse(data['dateOfBirth']), profileImgPath: data['profileImgPath']);
  }

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'level': level,
      'topScore': topScore,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(), // Convert DOB DateTime to string
      'profileImgPath': profileImgPath ?? "assets/images/player_1.png",
    };
  }


}