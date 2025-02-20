import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class TreeSurfaceLandAnimationManager {
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
  SpriteAnimation breakableAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
}