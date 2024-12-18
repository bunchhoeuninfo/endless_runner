import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Coin extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  final double speed = 200;
  final String _className = 'Coin';

  Coin(Vector2 position)
    : super(position: position, size: Vector2(30.0, 30.0)); // size of coin

  @override
  Future<void> onLoad() async {
    LogUtil.debug('Start inside $_className.onLoad...');
    super.onLoad();

    try {
      sprite = await gameRef.loadSprite('coin.jpg');
      add(RectangleHitbox());
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    LogUtil.debug('Start inside $_className.update ...');

    super.update(dt);

    position.x -= speed * dt;

    // Remove coin if it moves off-screen
    if (position.x < -size.x) {
      LogUtil.debug('Start inside $_className.update...Removed coin here');
      removeFromParent();
    }

  }

}