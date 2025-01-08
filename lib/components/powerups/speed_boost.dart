

import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SpeedBoost extends SpriteComponent with HasGameRef<EndlessRunnerGame> ,CollisionCallbacks {

  final double speed = 200;

  SpeedBoost({
    required Vector2 position,
  }) : super(position: position);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to initialize SpeedBoost sprite');
      sprite = Sprite(gameRef.images.fromCache('coins/rocket_coin.jpg'));
      size = Vector2(32, 32); // Adjust size as needed
      add(RectangleHitbox()); // Add collision detection

      LogUtil.debug('Succesfully initialized speed boost sprite');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= speed * dt;
    if (position.x < -size.x) removeFromParent();
  }

}