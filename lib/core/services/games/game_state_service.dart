import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:flutter/material.dart';

class GameStateService implements GameStateManager {

  // Singleton
  static final GameStateService _instance = GameStateService._internal();
  factory GameStateService() => _instance;
  GameStateService._internal();

  @override
  // TODO: implement stateNotifier
  ValueNotifier<GameState> stateNotifier = ValueNotifier<GameState>(GameState.start);
  
  @override
  void changeState(GameState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    stateNotifier.value = newState;
  });
  }

}