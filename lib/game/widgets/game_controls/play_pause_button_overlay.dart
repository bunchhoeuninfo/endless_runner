
import 'package:endless_runner/core/managers/game_service_manager.dart';
import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';


class PlayPauseButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame gameRef;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final GameStateManager _gameStateManager = GameStateManager();

  PlayPauseButtonOverlay({super.key, required this.gameRef}) ;

  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier,
      builder: (context, state, child) {
        LogUtil.debug('Building play pause button overlay, state: $state');
        LogUtil.debug('Game state: ${_gameStateManager.stateNotifier.value}');
        return Container();
      },
    );
    
    /*
   
    
    return 
      widget.game.overlays.isActive('start') || widget.game.overlays.isActive('restart')
      ? Container()
      :  _buildTopCenter(context);*/
  }

  void listenToGameState(void Function(GameState) onGameStateChanged) {
    _gameStateManager.stateNotifier.addListener(() {
      onGameStateChanged(_gameStateManager.stateNotifier.value);
    });
  }

  Align _buildTopCenter(BuildContext context, bool isPaused) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
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
        _gameStateManager.setState(GameState.playing);
        _gameServiceManager.pauseGame(gameRef);
      },
      child: const Icon(Icons.pause, size: 50, color: Colors.white),
    );
  }

  GestureDetector _buildPlayButton() {
    return GestureDetector(
      onTap: () {
        _gameStateManager.setState(GameState.paused);
        _gameServiceManager.startGame(gameRef);
      },
      child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
    );
  }
}

