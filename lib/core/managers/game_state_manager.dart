import 'package:endless_runner/core/state/game_state.dart';
import 'package:flutter/material.dart';

class GameStateManager {
  final ValueNotifier<GameState> _stateNotifier = ValueNotifier<GameState>(GameState.start);

  GameState get state => _stateNotifier.value;


  void setState(GameState newState) {
    _stateNotifier.value = newState;
  }

/*
  bool isMenu() => _state == GameState.menu;
  
  bool isPlaying() => _state == GameState.playing;
  bool isPaused() => _state == GameState.paused;
  bool isGameOver() => _state == GameState.gameOver;
*/
  bool isMenu() => _stateNotifier.value == GameState.menu;
  bool isPlaying() => _stateNotifier.value == GameState.playing;
  bool isPaused() => _stateNotifier.value == GameState.paused;
  bool isGameOver() => _stateNotifier.value == GameState.gameOver;

  ValueNotifier<GameState> get stateNotifier => _stateNotifier;


}