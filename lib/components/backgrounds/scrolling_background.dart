import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';

class ScrollingBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  final double speed; // Speed of the background movement
  final String className = 'ScrollingBackground';

  ScrollingBackground({required Vector2 position , required this.speed})
      : super(position: position);

  @override
  Future<void> onLoad() async {

    LogUtil.debug('Start inside $className.onLoad...');

    try {
      LogUtil.debug('Load sprite background_tile.jpg');
      // Make the background size equal to the screen size
      size = gameRef.size;
      sprite = await gameRef.loadSprite('background_tile.jpg'); // Full-screen background
      LogUtil.debug('$className loaded successfully');
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
      position.x += 2 * size.x; // Reset to the right of the screen
    }
  }
}