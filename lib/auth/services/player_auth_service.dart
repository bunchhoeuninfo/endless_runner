import 'dart:convert';
import 'dart:io';

import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerAuthService implements PlayerAuthManager {

  static const String playerKey = 'player_data';

  @override
  Future<PlayerData?> loadPlayerData() async {
    try {
      LogUtil.debug('Try to load player data');
      final prefs = await SharedPreferences.getInstance();
      final playerDataString = prefs.getString(playerKey);
      if (playerDataString != null) {
        final Map<String, dynamic> playerDataMap = jsonDecode(playerDataString);
        final pd = PlayerData.fromMap(playerDataMap);
        LogUtil.debug('Player data loaded succesfully -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
        return pd;
      }         
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    return null;        
  }

  @override
  Future<void> savePlayerData(PlayerData player) async {
    LogUtil.debug('Try to save player data');
    try {
      final prefs = await SharedPreferences.getInstance();
      final playerData = jsonEncode(player.toMap());
      await prefs.setString(playerKey, playerData);
      LogUtil.debug('Saved player data succesfully');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  Future<void> updatePlayerData(PlayerData updatedPlayerData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
    final playerDataString = prefs.getString('playerData');

    if (playerDataString != null) {
      final Map<String, dynamic> currentPlayerData = jsonDecode(playerDataString);
      currentPlayerData['playerName'] = updatedPlayerData.playerName;
      currentPlayerData['dateOfBirth'] = updatedPlayerData.dateOfBirth.toIso8601String();
      currentPlayerData['gender'] = updatedPlayerData.gender;

      final updatedDataString = jsonEncode(currentPlayerData);
      await prefs.setString('playerData', updatedDataString);

      LogUtil.debug('Updated player data successfully');
    } else {
      LogUtil.error('No existing player data to update');
    }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  Future<void> deleteProfileImg(String playerName) async {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = 'profile_$playerName.jpg';
    final String filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    if (await file.exists()) {
      await file.delete(); // Delete the image file
    }
  }

  @override
  Future<String?> getProfileImgPath(String playerName) async {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = 'profile_$playerName.jpg';
    final String filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    if (await file.exists()) {
      return filePath; // Return the path if the file exists
    }

    return null; // Return null if no image is found
  }

  @override
  Future<String> saveProfileImgPath(File imgFile, String playerName) async {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = 'profile_$playerName.jpg';
    final String filePath = '${directory.path}/$fileName';

    // Save the image locally
    await imgFile.copy(filePath);

    return filePath; // Return the saved image path
  }
 

}