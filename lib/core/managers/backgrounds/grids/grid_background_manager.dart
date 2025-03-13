import 'package:endless_runner/components/backgrounds/grid_background.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class GridBackgroundManager {
  void setGridBackgroundBounds(EndlessRunnerGame gameRef);
  SpriteAnimation applyGridBackgroundAnimationByState(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize);
  Future<Sprite> loadGridBackgroundSprite(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize);
  Future<List<SpriteComponent>> loadGridBgSpriteComponent(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize);
  void applyGridBgGravity(double dt, EndlessRunnerGame gameRef);
  void moveBgDownward();
  void stopMoving();
}