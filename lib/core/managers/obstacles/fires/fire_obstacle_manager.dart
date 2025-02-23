import 'package:endless_runner/components/obstacles/fire_obstacle.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class FireObstacleManager {
  void spawnFireObstacle(EndlessRunnerGame gameRef, double dt);
  void setFireObstacleSpawnBounds(EndlessRunnerGame gameRef);
  void checkFireObstacleGravity(double dt, FireObstacle fireObstacle);
  SpriteAnimation applyFireObstacleAnimationByState(EndlessRunnerGame gameRef, FireObstacle fireObstacle, Vector2 spriteSize);
}