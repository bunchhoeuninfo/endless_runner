import 'package:endless_runner/components/powerups/rocket_booster.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class RocketBoosterManager {
  void spawnRocketBooster(EndlessRunnerGame gameRef, double dt);
  void setRocketBoosterSpawnBounds(EndlessRunnerGame gameRef, double dt);
  void checkRocketBoosterGravity(double dt, RocketBooster rocketBooster);
  SpriteAnimation applyRocketBoosterAnimationByState(EndlessRunnerGame gameRef, RocketBooster rocketBooster, Vector2 spriteSize);
}