import 'package:endless_runner/components/surfacetoland/stone_surface_to_land.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class StoneSurfaceToLandManager {
  void spawnStoneSurfaceToLand(EndlessRunnerGame gameRef, double dt);
  void setStoneSurfaceToLandBounds(EndlessRunnerGame gameRef,);
  void checkStoneSurfaceToLandGravity(double dt, StoneSurfaceToLand stoneSurfaceToLand);
  SpriteAnimation applyStoneSurfaceToLandAnimationByState(EndlessRunnerGame gameRef, StoneSurfaceToLand stoneSurfaceToLand, Vector2 spriteSize);
}