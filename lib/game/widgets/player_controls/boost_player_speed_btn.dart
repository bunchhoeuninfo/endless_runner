import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class BoostPlayerSpeedBtn extends StatelessWidget {

  BoostPlayerSpeedBtn({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing ?
          _buildBoostSpeedBtn(context)
        : Container();
      }
    );
  }

  Align _buildBoostSpeedBtn(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight, // Align to the bottom-right of the screen
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 100), // Add padding for spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _boostSpeedBtn(),
          ],
        ),
      ),
    );
  }

  GestureDetector _boostSpeedBtn() {
    return GestureDetector(
      onTap: () {
        LogUtil.debug('Click boost player speed button control');
      },
      child: const Icon(Icons.speed, size: 50, color: Colors.white,),
    );
  }

}