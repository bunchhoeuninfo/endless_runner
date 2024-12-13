import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  Player() : super(size: Vector2(50, 50), position: Vector2(100, 300));

  bool _isJumping = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player_1.png');
  }

  void jump() {
    if (!_isJumping) {
      _isJumping = true;
      position.add(Vector2(0, -150));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (position.y < gameRef.size.y - 50) {
      position.add(Vector2(0, 300 * dt));
    } else {
      _isJumping = false;
      position.y = gameRef.size.y - 50;
    }
  }
}