import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerAuthService implements PlayerAuthManager {
  @override
  Future<PlayerData> loadPlayerData() async {
    LogUtil.debug('Inside loadPlayerData');
    //PlayerData playerData = const PlayerData(name: 'Player', level: 1, score: 0);
    try {
      final prefs = await SharedPreferences.getInstance();
      PlayerData playerData = PlayerData(name: prefs.getString('name') ?? 'Player', level: prefs.getInt('level') ?? 1, topScore: prefs.getInt('score') ?? 0);
      LogUtil.debug('Player data -> name: ${playerData.name}, level: ${playerData.level}, score: ${playerData.topScore}');
      return playerData;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
    LogUtil.debug('Player data is default');
    return const PlayerData(name: 'Player', level: 1, topScore: 0);
  }

  @override
  Future<void> savePlayerData(PlayerData playerData) async {
    LogUtil.debug('Inside savePlayerData method');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', playerData.name ?? 'PlayerName');
      await prefs.setInt('level', playerData.level ?? 1);
      await prefs.setInt('score', 0);
      LogUtil.debug('Saved player data succesfully');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
 

}