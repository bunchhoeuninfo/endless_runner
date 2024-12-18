/*

import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';

class ScrollingBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  final double speed = 100; // Speed of the background movement
  final String className = 'ScrollingBackground';

  ScrollingBackground({required double startX})
      : super(position: Vector2(startX, 0));

  @override
  Future<void> onLoad() async {

    LogUtil.debug('Start inside $className.onLoad...');

    try {
      // Make the background size equal to the screen size
      size = gameRef.size;
      sprite = await gameRef.loadSprite('background_tile.jpg'); // Full-screen background
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }    
  }

  @override
  void update(double dt) {
    super.update(dt);

    LogUtil.debug('Start inside $className.update...');
    // Move the background to the left
    position.x -= speed * dt;

    // If the background moves completely off-screen, reset its position
    if (position.x <= -size.x) {
      position.x = size.x; // Reset to the right of the screen
    }
  }
}
*/