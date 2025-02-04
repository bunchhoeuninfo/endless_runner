
import 'package:endless_runner/core/services/scores/live_score_service.dart';
import 'package:endless_runner/core/managers/games/game_service_manager.dart';
import 'package:endless_runner/core/services/games/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';

import 'package:flutter/material.dart';

class LevelUpOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final LiveScoreService _liveScoreService = LiveScoreService();

  LevelUpOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _buildLevelUpOverlay();
  }

  Center _buildLevelUpOverlay() {
    LogUtil.debug('Inside build _buildLevelUpCongrateOverlay');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              _buildRow(null, _liveScoreService.encouragementNotifier, Colors.amber),
              const SizedBox(height: 5),
              _buildRow('Player', _liveScoreService.playerNameNotifier, Colors.yellow),
              _buildRow('Level', _liveScoreService.levelNotifier, Colors.blue),
              const SizedBox(height: 20,),
            ],
          ),
          // Row for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              ElevatedButton(
                onPressed: () {                
                  _gameServiceManager.startGame(game);                                    
                  _liveScoreService.resetScore();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),              
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow<T>(String? label, ValueNotifier<T> notifier, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label != null ? '$label: ' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

}