import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class StoneSurfaceToLandAnimationManager {
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
  SpriteAnimation hitGroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
}