
import 'package:endless_runner/core/managers/games/game_service_manager.dart';
import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/services/games/game_service_service.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';


class ResumePauseButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame gameRef;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final GameStateManager _gameStateManager = GameStateService();

  ResumePauseButtonOverlay({super.key, required this.gameRef}) ;

  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier,
      builder: (context, state, child) {
        LogUtil.debug('Building play pause button overlay, state: $state');
        LogUtil.debug('Game state: ${_gameStateManager.stateNotifier.value}');
        if (state == GameState.paused) {
          return _buildTopCenter(context, false);
        } else if (state == GameState.resumed || state == GameState.playing) {
          return _buildTopCenter(context, true);
        }
        return Container();
      },
    );
  }

  Align _buildTopCenter(BuildContext context, bool isPaused) {
    return Align(
      alignment: Alignment.topRight,    // Move to the right side
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isPaused ?  _buildPauseButton() : _buildPlayButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildPauseButton() {
    return GestureDetector(
      onTap: () {
        _gameStateManager.stateNotifier.value = GameState.paused;
      },
      child: const Icon(Icons.pause, size: 50, color: Colors.white),
    );
  }

  GestureDetector _buildPlayButton() {
    return GestureDetector(
      onTap: () {
        _gameStateManager.stateNotifier.value = GameState.resumed;
        _gameServiceManager.resumeGame(gameRef);
      },
      child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
    );
  }
}

