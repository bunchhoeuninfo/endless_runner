
import 'package:flutter/material.dart';

abstract class LiveScoreManager {
  
  // --- Game Data Notifiers ---
  
  /// Notifier for the current score.
  ValueNotifier<int> get scoreNotifier;

  /// Notifier for the high score.
  ValueNotifier<int> get highScoreNotifier;

  /// Notifier for the current level.
  ValueNotifier<int> get levelNotifier;

  /// Notifier for the player's name.
  ValueNotifier<String> get playerNameNotifier;

  // Encourage the player to keep playing
  ValueNotifier<String> get encouragementNotifier;

  // --- Score Management ---

  /// Updates the current score and manages the high score logic.
  Future<void> updateScore(int increment);

  /// Resets the current score to zero.
  //void resetScore();

  /// Calculates the score needed for the next level.
  int getScoreThresholdForNextLevel(int currentLevel);

  // --- High Score Management ---

  /// Loads the high score from persistent storage.
  Future<void> loadHighScore();

  /// Resets the high score in memory and persistent storage.
  Future<void> resetHighScore();

  // --- Level Management ---

  /// Updates the current level to a new value.
  void updateLevel(int newLevel);

  // --- Game Progress Management ---

  /// Resets the entire game progress, including score, level, and high score.
  Future<void> resetGameProgress();

  /// Loads the saved game progress, including high score and level.
  Future<void> loadGameProgress();

  // Update live score board
  Future<void> saveLiveScoreBoard();
}