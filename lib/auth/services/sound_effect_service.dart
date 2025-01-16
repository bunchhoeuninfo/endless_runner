import 'dart:convert';

import 'package:endless_runner/auth/data/sound_effect_option.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/managers/sound_effect_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundEffectService implements SoundEffectManager {


  @override
  Future<void> saveSoundEffectSettings(SoundEffectOption settings) async {
    try {
      //final currentPlayerData = await _playerAuthManager.loadPlayerData();
      final prefs = await SharedPreferences.getInstance();
      final playerDataString = prefs.getString(GameConstant.playerKey);



      if (playerDataString != null) {
        final Map<String, dynamic> currentPlayerData = jsonDecode(playerDataString);
        currentPlayerData['profileImgPath'] = upd.profileImgPath;
        
        final updatedDataString = jsonEncode(currentPlayerData);
        await prefs.setString(GameConstant.playerKey, updatedDataString);

        LogUtil.debug('Updated sound effect setting successfully');
      } else {
        LogUtil.error('No existing player data to update');
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

}