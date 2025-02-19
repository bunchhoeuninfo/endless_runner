import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JumpControlBtn extends StatelessWidget {
  JumpControlBtn({super.key, required this.game});

  final EndlessRunnerGame game;
  final GameStateManager _gameStateManager = GameStateService();


  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start building jump control button');
    return _buildButton();
  }

  Widget _buildButton() {
    return ValueListenableBuilder<GameState>(
      valueListenable: _gameStateManager.stateNotifier, 
      builder: (context, state, child) {
        return state == GameState.playing
          ? _buildBottomJump(context)
          : Container();
      }
    );
  }

  Align _buildBottomJump(BuildContext context) {
    return Align(
      alignment: const Alignment (1, 1), // Bottom-right
      child: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),  // adjust spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bottomJump(),
          ],
        ),
      ),
    ); 
  }

  GestureDetector _bottomJump() {
    return GestureDetector(
      onTap: () {
        game.player.jump();
      },
      //child: const Icon(Icons., size: 50, color: Colors.amber,),
      child: const FaIcon(FontAwesomeIcons.superpowers, size: 50, color: Colors.amber,),
    );
  }

}