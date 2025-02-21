import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class UpwardControlButton extends StatelessWidget {
  UpwardControlButton({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start building upward control button');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing
          ? _buildBottomRight(context)
          : Container();
      }
    );
  }

  Align _buildBottomRight(BuildContext context) {
    return Align(
      alignment: const Alignment (1, 1), // Bottom-right
      child: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),  // adjust spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bottomRight(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _bottomRight() {
    return GestureDetector(
      onTap: () {
        game.player.moveUpward();
      },
      child: const Icon(Icons.arrow_upward, size: 50, color: Colors.amber,),
    );
  }
  

}