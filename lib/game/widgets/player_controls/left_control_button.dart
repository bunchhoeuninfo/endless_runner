import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LeftControlButton extends StatelessWidget {
  LeftControlButton({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();

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
      alignment: Alignment.centerLeft,
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
        LogUtil.debug('Click left button player control');
      },
      child: const Icon(Icons.arrow_back, size: 50, color: Colors.white),
    ); 
  }

}