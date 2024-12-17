import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/obstacles/obstacle.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {

  Player()
      : super(size: Vector2(50, 50), position: Vector2(100, 300)); // Fixed position

  final String className = 'Player';

  @override
  Future<void> onLoad() async {
    LogUtil.debug('Inside Player.onLoad method...');
    try {
      sprite = await gameRef.loadSprite('player_1.png'); // Load the player sprite
      add(RectangleHitbox());
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);

    LogUtil.debug('Start inside $className.onCollision.');

    if (other is Obstacle) {
      LogUtil.debug('Game Over: Player collided with obstacle!');
      // Add game-ver logic here, e.g., stop the game or reset
      gameRef.gameOver();
    }
  }

  void resetPosition() {
    position = Vector2(100, 300);
  }


}