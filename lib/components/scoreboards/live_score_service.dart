import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/components/scoreboards/live_score_manager.dart';
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
  final ValueNotifier<String> playerNameNotifier = ValueNotifier<String>('Unknown');
  
  @override
  Future<void> updateScore(int increment) async {
    try {
      LogUtil.debug('Try to update score');
      scoreNotifier.value += increment;
      // Update high score if the current score exceeds it
      if (scoreNotifier.value > highScoreNotifier.value) {
        highScoreNotifier.value = scoreNotifier.value;
      }

      // Save the new high score in persistent storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('highScore', highScoreNotifier.value);

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  @override
  Future<void> loadHighScore() async {
    try {
      LogUtil.debug('Try to load high score');
      final prefs = await SharedPreferences.getInstance();
      highScoreNotifier.value = prefs.getInt('highScore') ?? 0;
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
  void resetScore() {
    scoreNotifier.value = 0;
  }

  @override
  void updateLevel(int newLevel) {
    levelNotifier.value = newLevel;
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
      playerNameNotifier.value = playerData.playerName;  // Load player name
      highScoreNotifier.value = playerData.topScore;  // Load high score
      levelNotifier.value = playerData.level;  // Load current level, default 0
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override

  ValueNotifier<String> encouragementNotifier = ValueNotifier<String>(GameConstant.encouragementNotifier);

}