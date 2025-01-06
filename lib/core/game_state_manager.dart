import 'package:endless_runner/core/game_state.dart';

class GameStateManager {
  GameState _state = GameState.start;

  GameState get state => _state;

  void setState(GameState newState) {
    _state = newState;
  }

  bool isMenu() => _state == GameState.menu;
  bool isPlaying() => _state == GameState.playing;
  bool isPaused() => _state == GameState.paused;
}