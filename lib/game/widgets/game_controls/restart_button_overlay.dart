import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';

import 'package:flutter/material.dart';

class RestartButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();

  RestartButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Game Over',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _gameServiceManager.restartGame(game);
             // game.add(PlayPauseButton());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Tap to Restart',
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

  void resumeGame() {
    LogUtil.debug('Start method restartGame...');
    //game.add(PlayPauseButton());
    game.gameStateManager.setState(GameState.playing);
    game.resumeEngine();  //Resume the game loop              
    game.isFirstRun = false;        
    game.overlays.remove('restart');    
    game.coinScore = 0;
    game.coinCollected = 0;
    
    // Remove all objects from game screen
    game.children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
    game.children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
    game.children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());

  }
}