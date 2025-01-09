
import 'package:endless_runner/components/scoreboards/live_score_manager.dart';
import 'package:endless_runner/components/scoreboards/live_score_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LiveScoreBoard extends StatelessWidget {
  LiveScoreBoard({super.key});

  //final LiveScoreService _liveScoreService = LiveScoreService();
  final LiveScoreManager _liveScoreManager = LiveScoreService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _futureBuilder();
  }

  FutureBuilder _futureBuilder() {
    LogUtil.debug('Inside future builder method');
    return FutureBuilder(
      future: _liveScoreManager.loadGameProgress(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading progress'),);
        } else {
          return _liveScoreBoard();
        }        
      },
    );
  }


  Positioned _liveScoreBoard() {
    LogUtil.debug('Build live score board position to display score: ${_liveScoreManager.scoreNotifier}, high score: ${_liveScoreManager.highScoreNotifier}, level: ${_liveScoreManager.levelNotifier}');
    return Positioned(
      top: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Player', _liveScoreManager.playerNameNotifier, Colors.amber),
          _buildRow('Score', _liveScoreManager.scoreNotifier, Colors.yellow),
          //const SizedBox(height: 5), // Space between rows
          _buildRow('High Score', _liveScoreManager.highScoreNotifier, Colors.green),
          //const SizedBox(height: 5,),
          _buildRow('Level', _liveScoreManager.levelNotifier, Colors.blue),
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
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

}