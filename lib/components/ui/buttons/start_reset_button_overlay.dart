
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

import 'package:flutter/material.dart';

class StartResetButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();

  StartResetButtonOverlay({
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
              ElevatedButton(
                onPressed: () {
                  _gameServiceManager.startGame(game);                                    
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Start',
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