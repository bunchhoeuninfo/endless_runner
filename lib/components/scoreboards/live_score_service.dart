import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LiveScoreService {
  
  
  static final LiveScoreService _instance = LiveScoreService._internal();
  factory LiveScoreService() => _instance;
  LiveScoreService._internal();

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> levelNotifier = ValueNotifier<int>(1);

  
  void updateScore(int increment) {
    try {
      LogUtil.debug('Try to update score');
      scoreNotifier.value += increment;
      // Update high score if the current score exceeds it
      if (scoreNotifier.value > highScoreNotifier.value) {
        highScoreNotifier.value = scoreNotifier.value;
      }
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

}