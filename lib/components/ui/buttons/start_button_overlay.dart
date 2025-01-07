
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';

import 'package:flutter/material.dart';

class StartButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();

  StartButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [          
          ElevatedButton(
            onPressed: () {
              LogUtil.debug('Click start game.');
              //game.startGame();
              _gameServiceManager.startGame(game);
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