import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/core/managers/live_score_manager.dart';
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveScoreService implements LiveScoreManager {
  // Singleton
  static final LiveScoreService _instance = LiveScoreService._internal();
  factory LiveScoreService() => _instance;
  LiveScoreService._internal();

  final PlayerAuthManager _playerAuthManager = PlayerAuthService();

    // Notifiers
  @override
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);

  @override
  final ValueNotifier<int> levelNotifier = ValueNotifier<int>(1);
  
  @override
  final ValueNotifier<String> encouragementNotifier = ValueNotifier<String>(GameConstant.encouragementNotifier);

  @override
  final ValueNotifier<String> playerNameNotifier = ValueNotifier<String>('Unknown');

  @override
  // TODO: implement resetNotifier
  ValueNotifier<bool> resetNotifier = ValueNotifier<bool>(false);

  // New method to listen to highScoreNotifier
  void listenToHighScore(void Function(int) onHighScoreChanged) {
    highScoreNotifier.addListener(() {
      onHighScoreChanged(highScoreNotifier.value);
    });
  }

  void listentoLevel(void Function(int) onLevelChanged) {
    levelNotifier.addListener(() {
      onLevelChanged(levelNotifier.value);
    });
  }
  
  @override
  Future<void> updateScore(int increment) async {
    try {
      LogUtil.debug('Try to update score');
      scoreNotifier.value += increment;
      // Update high score if the current score exceeds it
      if (scoreNotifier.value > highScoreNotifier.value) {
        highScoreNotifier.value = scoreNotifier.value;
      }

      if (scoreNotifier.value >= getScoreThresholdForNextLevel(levelNotifier.value)) {
        _updateEncouragementNotifier();
        //_gameServiceManager.levelUp();
        levelNotifier.value += 1;
        //scoreNotifier.value = 0; // Reset score after level up
        //highScoreNotifier.value = 0; // Reset high score after level up
      }

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  void _updateEncouragementNotifier() {
    if (levelNotifier.value == 1) {
      encouragementNotifier.value = GameConstant.encouragementNotifierLevel1;
    }
    if (levelNotifier.value == 2) {
      encouragementNotifier.value = GameConstant.encouragementNotifierLevel2;
    }
    if (levelNotifier.value == 3) {
      encouragementNotifier.value = GameConstant.encouragementNotifierLevel3;
    }
  }

  @override
  Future<void> loadHighScore() async {
    try {
      LogUtil.debug('Try to load high score');
      final pd = await _playerAuthManager.loadPlayerData();
      if (pd == null) {
        return;
      }
      highScoreNotifier.value = pd.topScore;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  Future<void> resetHighScore() async {
    try {
      LogUtil.debug('Try to reset high score');
      highScoreNotifier.value = 0;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('highScore');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void updateLevel(int newLevel) {
    try {
      LogUtil.debug('Try to update level');
      scoreNotifier.value = 0; // Reset score after level up
      highScoreNotifier.value = 0; // Reset high score after level up
      levelNotifier.value = newLevel;
      LogUtil.debug('Level updated to $newLevel');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }  
  }

  @override
  Future<void> resetGameProgress() async {
    try {
      scoreNotifier.value = 0;
      levelNotifier.value = 0;

      // Clear saved high score and level
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('highScore');
      await prefs.remove('currentLevel');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  // Function to calculate the score needed for the next level
  @override
  int getScoreThresholdForNextLevel(int currentLevel) {
    return 500 + (currentLevel - 1) * 100; // Level 1 -> 500, Level 2 -> 600, Level 3 -> 700
  }

  @override
  Future<void> loadGameProgress() async {
    try {      
      LogUtil.debug('Try to load game progress');
      final playerData = await _playerAuthManager.loadPlayerData();
      if (playerData == null) {
        return;
      }
      //scoreNotifier.value = 0;  // Reset current score
      playerNameNotifier.value = playerData.playerName;  // Load player name
      highScoreNotifier.value = playerData.topScore;  // Load high score
      levelNotifier.value = playerData.level;  // Load current level, default 0
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  
  
  @override
  Future<void> saveLiveScoreBoard() async {
    try {
      
      scoreNotifier.value = 0; // Reset current score
      final playerData = await _playerAuthManager.loadPlayerData();
      if (playerData == null) {
        LogUtil.error('No player data found');
        return;
      }

      listenToHighScore((newHighScore) {
        highScoreNotifier.value = newHighScore;
      });

      listentoLevel((newLevel) {
        levelNotifier.value = newLevel;
      });

      if (highScoreNotifier.value > playerData.topScore) {
        playerData.topScore = highScoreNotifier.value;
      }
      if (levelNotifier.value > playerData.level) {
        playerData.level = levelNotifier.value;
      }

      LogUtil.debug('Try to update live score board, high score: ${highScoreNotifier.value}, level: ${levelNotifier.value}');
      await _playerAuthManager.updatePlayerData(playerData);
      LogUtil.debug('Successfully updated live score board to shared preferences');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  Future<void> resetLiveScoreBoard() async {
    try {
      scoreNotifier.value = 0;
      highScoreNotifier.value = 0;
      levelNotifier.value = 1;
      
      final playerData = await _playerAuthManager.loadPlayerData();
      if (playerData == null) {
        LogUtil.error('No player data found');
        return;
      }
      playerData.topScore = 0;
      playerData.level = 1;
      await _playerAuthManager.updatePlayerData(playerData);
      LogUtil.debug('Successfully updated live score board to shared preferences');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  Future<void> resetScore() async {
    try {
      scoreNotifier.value = 0;
      highScoreNotifier.value = 0;
      
      final playerData = await _playerAuthManager.loadPlayerData();
      if (playerData == null) {
        LogUtil.error('No player data found');
        return;
      }
      playerData.topScore = 0;
      await _playerAuthManager.updatePlayerData(playerData);
      LogUtil.debug('Successfully updated live score board to shared preferences');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  
}