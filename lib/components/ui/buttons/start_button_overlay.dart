import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

import 'package:flutter/material.dart';

class StartButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;

  const StartButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [          
          ElevatedButton(
            onPressed: () {
              game.overlays.remove('start');
              game.gameStateManager.setState(GameState.playing);
              game.resumeEngine();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Start',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}