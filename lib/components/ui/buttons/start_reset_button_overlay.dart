
import 'package:endless_runner/components/scoreboards/live_score_service.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';

import 'package:flutter/material.dart';

class StartResetButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final LiveScoreService _liveScoreService = LiveScoreService();

  StartResetButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _futureBuilder();
  }

  FutureBuilder _futureBuilder() {
    LogUtil.debug('Inside future builder');
    return FutureBuilder(
      future: _liveScoreService.loadGameProgress(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading progress'),);
        } else {
          return _buildPlayerProgresInfo();
        }    
      }
    );
  }

  Center _buildPlayerProgresInfo() {
    LogUtil.debug('Inside build player progress info method');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              _buildRow('Player', _liveScoreService.playerNameNotifier, Colors.yellow),
              const SizedBox(height: 5),
              _buildRow('Top Score', _liveScoreService.highScoreNotifier, Colors.green),
              const SizedBox(height: 5,),
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

  Widget _buildRow<T>(String label, ValueNotifier<T> notifier, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
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