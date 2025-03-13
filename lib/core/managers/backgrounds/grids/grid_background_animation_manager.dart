import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class GridBackgroundAnimationManager {
  SpriteAnimation loopingBackgroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize);
  
}