import 'dart:convert';
import 'dart:io';

import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/services.dart';
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

    LogUtil.debug('Return null');
    DateTime now = DateTime.now(); // Get the current date and time
    String currentDate = now.toIso8601String().split('T').first; // Extract the date in ISO 8601 format (YYYY-MM-DD)    
    return PlayerData(playerName: 'UNKNOWN', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(currentDate), profileImgPath: await _getDefaultProfileImage());        
  }

   Future<String> _getDefaultProfileImage() async {
      // Load the asset image
    final byteData = await rootBundle.load('assets/images/player_1.png');

    // Save the asset image as a temporary file
    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/default_profile_image.png';
    final File file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file.path;   

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
  Future<void> updatePlayerData(PlayerData upd) async {
    LogUtil.debug('Try to update player data -> name: ${upd.playerName}, dob: ${upd.dateOfBirth}, level: ${upd.level}, score: ${upd.topScore}, gender: ${upd.gender}, img: ${upd.profileImgPath}');
    try {
      final prefs = await SharedPreferences.getInstance();
      final playerDataString = prefs.getString(playerKey);

      if (playerDataString != null) {
        final Map<String, dynamic> currentPlayerData = jsonDecode(playerDataString);
        currentPlayerData['playerName'] = upd.playerName;
        currentPlayerData['dateOfBirth'] = upd.dateOfBirth.toIso8601String();
        currentPlayerData['gender'] = upd.gender;
        currentPlayerData['profileImgPath'] = upd.profileImgPath;
        
        final updatedDataString = jsonEncode(currentPlayerData);
        await prefs.setString(playerKey, updatedDataString);

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
    LogUtil.debug('Try to get profile image path , player name-> $playerName');
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = 'profile_$playerName.jpg';
      final String filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      if (await file.exists()) {
        LogUtil.debug('File does exist -> $file');
        return filePath; // Return the path if the file exists
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
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