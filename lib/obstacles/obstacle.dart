import 'package:endless_runner/endless_runner_game.dart';

import 'package:flame/components.dart';

class Obstacle extends SpriteComponent  with HasGameRef<EndlessRunnerGame> {
  final double moveSpeed = 50; // Speed of obstacle movement
  double direction = -1; // Direction: -1 for left, 1 for right

  Obstacle({required double startX, required double startY})
      : super(size: Vector2(50, 50), position: Vector2(startX, startY));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player_1.png'); // Load the obstacle's sprite
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move the obstacle left or right
    position.x += direction * moveSpeed * dt;

    // Reverse direction if it hits the screen edges
    if (position.x < 0 || position.x > gameRef.size.x - size.x) {
      direction *= -1;
    }
  }

}