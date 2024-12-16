import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  Player() : super(size: Vector2(50, 50), position: Vector2(50, 300));

  final double moveSpeed = 100; // Speed of movement

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player_1.png'); // Load the player's sprite
  }

  void moveRight() {
    // Move the player to the right
    position.x += moveSpeed;
    if (position.x > gameRef.size.x - size.x) {
      position.x = gameRef.size.x - size.x; // Prevent moving off-screen
    }
    print("Player moved right to position: $position");
  }
}