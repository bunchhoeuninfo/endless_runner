import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/managers/players/player_movement_manager.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/services/players/player_movement_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LeftControlButton extends StatelessWidget {
  LeftControlButton({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();
  final PlayerMovementManager _playerMovementManager = PlayerMovementService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start LeftControlButton build');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing ?
          _buildLeftCenter(context)
        :  Container();
      });
  }

  Align _buildLeftCenter(BuildContext context) {
    return Align(
      alignment: const Alignment (-1, 0.5),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _leftButton(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _leftButton() {
    return GestureDetector(
    onTap: () {
      LogUtil.debug('Click move left button');
      //_playerMovementManager.moveLeft();
      game.player.moveLeft();
    },
      child: const Icon(Icons.arrow_back, size: 50, color: Colors.white),
    ); 
  }

}