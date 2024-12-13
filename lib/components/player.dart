import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  Player() : super(size: Vector2(50, 50), position: Vector2(100, 300));

  final bool _isJumping = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player_1.png');
  }

  void _jump() {
    if (!_isJumping) {
      
    }
  }
}