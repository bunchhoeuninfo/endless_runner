import 'package:endless_runner/components/surfacetoland/tree_surface_to_land.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class TreeSurfaceToLandManager {
  void setTreeSurfaceLandSpawnBounds();
  void spawnTreeSurfaceToLand(EndlessRunnerGame gameRef, double dt);
  void spawnTreeSurfaceLandWithBreakable();
  void spawnTreeSurfaceLandWithCoin();
  void applyGravity(double dt, TreeSurfaceToLand treeSurface, EndlessRunnerGame gameRef);
  void handlePlayerLanding(PositionComponent player, TreeSurfaceToLand treeSurface, EndlessRunnerGame gameRef);
  void handlePlayerLandingWithBreakable(PositionComponent player, TreeSurfaceToLand treeSurface, EndlessRunnerGame gameRef);
  void checkTreeToLandGravity(double dt, TreeSurfaceToLand treeSurace);
}