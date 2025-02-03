import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/managers/player_movement_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/services/player_movement_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class RightControlBtn extends StatelessWidget {

  RightControlBtn({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();
  final PlayerMovementManager _playerMovementManager = PlayerMovementService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start RightControlButton build');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing ?
          _buildRightControl(context)
        : Container();
      }
    );
  }

  Align _buildRightControl(BuildContext context) {
    return Align(
      alignment: const Alignment (-1, 0.5),
      child: Padding(
        padding: const EdgeInsets.only(left: 120),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _rightButton(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _rightButton() {
    return GestureDetector(
    onTap: () {
      LogUtil.debug('Click right control');
      //_playerMovementManager.moveRight();
      game.player.moveRight();
    },
      child: const Icon(Icons.arrow_forward, size: 50, color: Colors.white),
    ); 
  }

}