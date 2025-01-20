
import 'package:endless_runner/core/managers/live_score_manager.dart';
import 'package:endless_runner/core/services/live_score_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class LiveScoreBoard extends StatelessWidget {
  LiveScoreBoard({super.key});

  final LiveScoreManager _liveScoreManager = LiveScoreService();
  final ValueNotifier<bool> _resetNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _liveScoreBoard();
    //return _congrateStack();
  }

  Stack _congrateStack() {
    LogUtil.debug('Inside _stack method');
    return Stack(
      children: [
        _liveScoreBoard(),
        ValueListenableBuilder<int>(
          valueListenable: _liveScoreManager.levelNotifier,
          builder: (context, level, child) {
            if (level > 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Congratulations!'),
                      content: Text('You have leveled up!'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            }
            return const SizedBox.shrink(); // Return an empty widget
          },
        ),
      ],
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
          _buildRow('High Score', _liveScoreManager.highScoreNotifier, Colors.green),          
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