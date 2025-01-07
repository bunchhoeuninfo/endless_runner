
import 'package:endless_runner/components/scoreboards/live_score_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LiveScoreBoard extends StatelessWidget {
/*  const LiveScoreBoard({super.key, required this.scoreNotifier, required this.highScoreNotifier, required this.levelNotifier});

  final ValueNotifier<int> scoreNotifier;
  final ValueNotifier<int> highScoreNotifier;
  final ValueNotifier<int> levelNotifier;*/
   LiveScoreBoard({super.key});

  final LiveScoreService _liveScoreService = LiveScoreService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _liveScoreBoard();
  }

  Positioned _liveScoreBoard() {
    LogUtil.debug('Build live score board position to display score: ${_liveScoreService.scoreNotifier}, high score: ${_liveScoreService.highScoreNotifier}, level: ${_liveScoreService.levelNotifier}');
    return Positioned(
      top: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Score', _liveScoreService.scoreNotifier, Colors.yellow),
          const SizedBox(height: 5), // Space between rows
          _buildRow('High Score', _liveScoreService.highScoreNotifier, Colors.green),
          const SizedBox(height: 5,),
          _buildRow('Level', _liveScoreService.levelNotifier, Colors.blue),
        ],
      ),
    );
  }

   Widget _buildRow(
      String label, ValueNotifier<int> notifier, Color valueColor) {
    return ValueListenableBuilder<int>(
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