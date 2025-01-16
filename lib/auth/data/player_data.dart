class PlayerData {
  String playerName;
  int level;
  int topScore;
  String gender;
  DateTime dateOfBirth;
  String? profileImgPath;
  Map<String, dynamic> settings;
  

  PlayerData({
    required this.playerName,
    required this.level,
    required this.topScore,
    required this.gender,
    required this.dateOfBirth,
    required this.profileImgPath,    
    required Map<String, dynamic>? settings, // Accept nullable settings
  })  : settings = settings ?? {
          "soundEffects": {
            "backgroundMusic": true,
            "buttonClickSound": true,
            "gameOverSound": true,
          },
          "playerAppearance": {            
            "playerSkin1": "classic",
            "playerSkin2": "Modern",
          },
          "gameThemse": {
            "background1": "default",
            "background2": "modern",
          }
        };

  factory PlayerData.fromMap(Map<String, dynamic> data) {
    return PlayerData(playerName: data['playerName'], level: data['level'], topScore: data['topScore'],
    gender: data['gender'], dateOfBirth: DateTime.parse(data['dateOfBirth']), profileImgPath: data['profileImgPath'],
    settings: Map<String, dynamic>.from(data['settings'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'level': level,
      'topScore': topScore,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(), // Convert DOB DateTime to string
      'profileImgPath': profileImgPath ?? "assets/images/player_1.png",
      'settings': settings,
    };
  }


}