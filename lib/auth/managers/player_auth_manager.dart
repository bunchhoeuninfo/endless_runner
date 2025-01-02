import 'package:endless_runner/auth/data/player_data.dart';

abstract class PlayerAuthManager {
  Future<PlayerData> loadPlayerData();
  Future<void> savePlayerData(PlayerData playerData);
}