import 'package:endless_runner/components/surfacetoland/tree_surface.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class TreeSurfaceLandManager {
  void setTreeSurfaceLandSpawnBounds();
  void spawnTreeSurfaceToLand(EndlessRunnerGame gameRef);
  void spawnTreeSurfaceLandWithBreakable();
  void spawnTreeSurfaceLandWithCoin();
  void applyGravity(double dt, TreeSurface treeSurface, EndlessRunnerGame gameRef);
  void handlePlayerLanding(PositionComponent player, TreeSurface treeSurface, EndlessRunnerGame gameRef);
  void handlePlayerLandingWithBreakable(PositionComponent player, TreeSurface treeSurface, EndlessRunnerGame gameRef);
}