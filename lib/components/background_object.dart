import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class BackgroundObject extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  final double speed;

  BackgroundObject({
    required double startX,
    required double startY,
    required this.speed,
  }) : super(position: Vector2(startX, startY), size: Vector2(100, 50));

  @override
  Future<void> onLoad() async {
    sprite =
        await gameRef.loadSprite('background_object.PNG'); // Load background sprite
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move the background object to the left
    position.x -= speed * dt;

    // Reset the object to the right once it moves off-screen
    if (position.x < -size.x) {
      position.x = gameRef.size.x;
    }
  }

}