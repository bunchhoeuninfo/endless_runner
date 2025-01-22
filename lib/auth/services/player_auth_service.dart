import 'dart:convert';
import 'dart:io';

import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/core/managers/player_data_notifier_manager.dart';
import 'package:endless_runner/core/services/player_data_notifier_service.dart';

import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerAuthService implements PlayerAuthManager {  

/*
  // Singleton
  static final PlayerAuthService _instance = PlayerAuthService._internal();
  factory PlayerAuthService() => _instance;
  PlayerAuthService._internal();*/



  //DateTime now = DateTime.now(); // Get the current date and time
  //String currentDate = DateTime.now().toIso8601String().split('T').first; // Extract the date in ISO 8601 format (YYYY-MM-DD)    
  
  //final LiveScoreManager _liveScoreManager = LiveScoreService();
  final PlayerDataNotifierManager _playerDataNotifierManager = PlayerDataNotifierService();

  @override
  Future<PlayerData?> loadPlayerData() async {
    try {
      LogUtil.debug('Try to load player data');
      final prefs = await SharedPreferences.getInstance();
      final playerDataString = prefs.getString(GameConstant.playerKey);
      //final playerDataString = prefs.getString(GameConstant.playerKey);
      if (playerDataString != null) {
        final Map<String, dynamic> playerDataMap = jsonDecode(playerDataString);
        final pd = PlayerData.fromMap(playerDataMap);
        LogUtil.debug('Player data loaded succesfully -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}, settings: ${pd.settings}');
        _playerDataNotifierManager.playerDataNotifier.value = pd;
        return pd;
      }         
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    LogUtil.debug('Return null');
    DateTime now = DateTime.now(); // Get the current date and time
    String currentDate = now.toIso8601String().split('T').first; // Extract the date in ISO 8601 format (YYYY-MM-DD)    
    
    //return null;
    return PlayerData(playerName: 'Unknown', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(currentDate), profileImgPath: await _getDefaultProfileImage(), settings: null);        
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
      //_liveScoreManager.playerDataNotifier.value = player;
      _playerDataNotifierManager.playerDataNotifier.value = player;
      await prefs.setString(GameConstant.playerKey, playerData);
      LogUtil.debug('Saved player data succesfully');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  Future<void> updatePlayerData(PlayerData upd) async {
    LogUtil.debug('Try to update player data -> name: ${upd.playerName}, dob: ${upd.dateOfBirth}, level: ${upd.level}, score: ${upd.topScore}, gender: ${upd.gender}, img: ${upd.profileImgPath}, settings: ${upd.settings}');
    try {
      final prefs = await SharedPreferences.getInstance();
      final playerDataString = prefs.getString(GameConstant.playerKey);

      if (playerDataString != null) {
        final Map<String, dynamic> currentPlayerData = jsonDecode(playerDataString);
        currentPlayerData['playerName'] = upd.playerName;
        currentPlayerData['dateOfBirth'] = upd.dateOfBirth.toIso8601String();
        currentPlayerData['level'] = upd.level;
        currentPlayerData['topScore'] = upd.topScore;
        currentPlayerData['gender'] = upd.gender;
        currentPlayerData['profileImgPath'] = upd.profileImgPath;
        currentPlayerData['settings'] = upd.settings;
        
        final updatedDataString = jsonEncode(currentPlayerData);
        //_liveScoreManager.playerDataNotifier.value = upd;
        _playerDataNotifierManager.playerDataNotifier.value = upd;
        await prefs.setString(GameConstant.playerKey, updatedDataString);

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

  
  
  @override
  Future<void> savePlayerSettings(PlayerData playerData) {
    // TODO: implement savePlayerSettings
    throw UnimplementedError();
  }
  
  @override
  Future<void> updatePlayerSettings(PlayerData playerData) {
    // TODO: implement updatePlayerSettings
    throw UnimplementedError();
  }
  
  @override
  Future<void> deletePlayerData() async {
    try {
      LogUtil.debug('Try to delete player data');
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) => value.remove(GameConstant.playerKey));
      _playerDataNotifierManager.playerDataNotifier.value = PlayerData(playerName: 'Unknown', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(DateTime.now().toIso8601String().split('T').first), profileImgPath: null, settings: null);
      LogUtil.debug('Player data deleted successfully');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  //@override
  // TODO: implement playerDataNotifier
  //ValueNotifier<PlayerData> playerDataNotifier = ValueNotifier<PlayerData>(PlayerData(playerName: 'Unknown', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(DateTime.now().toIso8601String().split('T').first), profileImgPath: null, settings: null)  );

}