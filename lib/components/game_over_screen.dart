import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends PositionComponent with HasGameRef<EndlessRunnerGame> {

  final VoidCallback onRestart;

  GameOverScreen({required this.onRestart});

  @override
  Future<void> onLoad() async {
    LogUtil.debug('Start inside GameOverScreen.onLoad...');
    try {
      final gameOverText = TextComponent(
        text: 'Game Over',
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 48, color: Color(0xFFFFFFFF)),
        ),
        position: Vector2(gameRef.size.x / 2 - 100, gameRef.size.y / 2 - 100),
      );

      final restartText = TextComponent(
        text: 'Tap to Restart',
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 24, color: Color(0xFFFFFFFF)),
        ),
        position: Vector2(gameRef.size.x / 2 - 100, gameRef.size.y / 2),
      );

      add(gameOverText);
      add(restartText);
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }
  }

  void onTapDown(TapDownInfo info) {
    onRestart();
    removeFromParent();
  }

}