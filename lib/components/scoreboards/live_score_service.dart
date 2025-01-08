import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveScoreService {
  // Singleton pattern
  static final LiveScoreService _instance = LiveScoreService._internal();
  factory LiveScoreService() => _instance;
  LiveScoreService._internal();

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> levelNotifier = ValueNotifier<int>(1);
  final ValueNotifier<String> playerNameNotifier = ValueNotifier<String>('Unknown');

  
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

  Future<void> loadHighScore() async {
    try {
      LogUtil.debug('Try to load high score');
      final prefs = await SharedPreferences.getInstance();
      highScoreNotifier.value = prefs.getInt('highScore') ?? 0;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

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

  void resetScore() {
    scoreNotifier.value = 0;
  }

  void updateLevel(int newLevel) {
    levelNotifier.value = newLevel;
  }

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
  int getScoreThresholdForNextLevel(int currentLevel) {
    return 500 + (currentLevel - 1) * 100; // Level 1 -> 500, Level 2 -> 600, Level 3 -> 700
  }

  Future<void> loadGameProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      highScoreNotifier.value = prefs.getInt('highScore') ?? 0;  // Load high score
      levelNotifier.value = prefs.getInt('currentLevel') ?? 1;  // Load current level, default 0
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}