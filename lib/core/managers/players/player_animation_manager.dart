import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class PlayerAnimationManager {
   SpriteAnimation walkingAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
   SpriteAnimation jumpingAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
   SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
   SpriteAnimation upwardAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
  
}