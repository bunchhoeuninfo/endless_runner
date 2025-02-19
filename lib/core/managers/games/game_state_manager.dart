import 'package:endless_runner/core/state/game_state.dart';
import 'package:flutter/material.dart';

abstract class GameStateManager {

  // --- Game State Management ---
  ValueNotifier<GameState> get stateNotifier;

  void changeState(GameState newState);

}