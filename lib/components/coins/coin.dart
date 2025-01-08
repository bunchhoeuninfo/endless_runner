import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Coin extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  final double speed = 200;
  final CoinType type;

  Coin(Vector2 position, this.type)
    : super(position: position, size: Vector2(30, 30));

  @override
  Future<void> onLoad() async {
    //LogUtil.debug('Start inside coin object onLoad...');
    super.onLoad();

    try {
      //sprite = await gameRef.loadSprite('coins/coin_flip.jpg');
      LogUtil.debug('Try to load coin sprite');

      // Load the appropriate sprite based on the coin type
      switch (type) {
        case CoinType.gold:
          sprite = Sprite(gameRef.images.fromCache('coins/gold.jpg'));
          break;
        case CoinType.red:
          sprite = Sprite(await gameRef.images.load('coins/red.jpg'));
          break;
        case CoinType.blue:
          sprite = Sprite(await gameRef.images.load('coins/blue.jpg'));
          break;
      }

      LogUtil.debug('Succesfully load coin $type');

      add(RectangleHitbox());      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    //LogUtil.debug('Start inside $_className.update ...');
    super.update(dt);

    position.x -= speed * dt;
    // Remove coin if it moves off-screen
    if (position.x < -size.x) {
      //LogUtil.debug('Start inside $_className.update...Removed coin here');
      removeFromParent();
    }

  }

}