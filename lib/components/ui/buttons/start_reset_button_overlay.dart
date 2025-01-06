import 'package:endless_runner/components/ui/buttons/play_pause_button.dart';
import 'package:endless_runner/components/ui/texts/coin_counter.dart';
import 'package:endless_runner/components/ui/texts/coin_score.dart';
import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';

import 'package:flutter/material.dart';

class StartResetButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;

  const StartResetButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              Text(
                'Player: John Doe', // Replace with the actual player name
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                'Top Score: 1200', // Replace with the actual top score
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Level: 5', // Replace with the actual level
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20), // Add spacing between top and buttons
            ],
          ),
          // Row for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Start button
              ElevatedButton(
                onPressed: () {
                  game.resumeEngine();
                  game.gameStateManager.setState(GameState.playing);
                  //game.add(PlayPauseButton());
                  //Score board
                  //game.add(CoinScore());
                  //game.add(CoinCounter());
                  game.overlays.remove('start');
                                    
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              const SizedBox(width: 20), // Add spacing between the buttons
              // Reset button
              ElevatedButton(
                onPressed: () {
                  LogUtil.debug('Clicked reset button');
                  // Reset logic here
                  game.restartGame(); // Example: replace with your reset implementation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }

}