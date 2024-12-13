
import 'dart:math';

import 'package:endless_runner/components/player.dart';
import 'package:endless_runner/obstacles/obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector {
   late Player player;
  late TimerComponent obstacleTimer;
  final Random random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Load the player
    player = Player();
    add(player);

    // Setup obstacle spawning
    obstacleTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: spawnObstacle,
    );
    add(obstacleTimer);
  }

  void spawnObstacle() {
    final obstacle = Obstacle()
      ..position = Vector2(size.x, size.y - 100) // Position it at the ground level
      ..velocity = Vector2(-200, 0); // Moving left
    add(obstacle);
  }

  @override
  void onTapDown(TapDownInfo info) {
    player.jump();
  }

}