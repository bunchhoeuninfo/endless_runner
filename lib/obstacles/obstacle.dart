import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Obstacle extends SpriteComponent  with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();

  Obstacle() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('obstacle.png'); // Replace with your sprite
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt);

    // Remove the obstacle if it goes off-screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

}