import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class PlayerJumpBtn extends StatelessWidget {
  
  PlayerJumpBtn({super.key, required this.game});
  
  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start PlaPlayerJumpControlButton build');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing ?
          _buildJumpBtn(context)
        : Container();
      }
    );
  }

  Align _buildJumpBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight, // Align to the bottom-right of the screen
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 40), // Add padding for spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _jumpBtn(),
          ],
        ),
      ),
    );
  }

  GestureDetector _jumpBtn() {
    return GestureDetector(
      onTap: () {
        LogUtil.debug('Click player jump button control');
      },
      child: const Icon(Icons.power, size: 50, color: Colors.white,),
    );
  }


}