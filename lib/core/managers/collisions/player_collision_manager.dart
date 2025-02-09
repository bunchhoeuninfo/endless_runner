import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class PlayerCollisionManager {
  void handleObstacleCollision(PositionComponent other, EndlessRunnerGame gameRef);
  void handleCollision(PositionComponent other, EndlessRunnerGame gameRef);
}