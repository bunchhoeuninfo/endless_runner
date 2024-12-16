
import 'package:endless_runner/components/player.dart';
import 'package:endless_runner/obstacles/obstacle.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector   {
   late Player player;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Add the player
    player = Player();
    add(player);

    // Add some obstacles
    for (int i = 0; i < 5; i++) {
      add(Obstacle(startX: size.x - i * 150, startY: size.y / 2));
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Make the player move right on tap
    player.moveRight();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update other game logic if needed
  }

}