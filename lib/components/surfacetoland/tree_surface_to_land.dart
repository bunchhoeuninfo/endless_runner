

import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_animation_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/services/surfacelands/trees/tree_surface_to_land_animation_service.dart';
import 'package:endless_runner/core/services/surfacelands/trees/tree_surface_to_land_service.dart';
import 'package:endless_runner/core/services/surfacelands/trees/tree_surface_to_land_state_service.dart';
import 'package:endless_runner/core/state/tree_surface_to_land_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TreeSurfaceToLand extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  double speed = 200; // Speed of tree movement
  TreeSurfaceToLand({required Vector2 position})
      :super(position: position, size: Vector2(90, 120));

  final TreeSurfaceToLandStateManager _treeSurfaceStateManager = TreeSurfaceToLandStateService();
  final TreeSurfaceToLandAnimationManager _animationManager = TreeSurfaceToLandAnimationService();
  final TreeSurfaceToLandManager _treeSurfaceLandManager = TreeSurfaceToLandService();
  final spriteSize = Vector2(300, 370);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Start inside TreeSurface.onload...');
    try {
      _treeSurfaceStateManager.stateNotifier.value = TreeSurfaceToLandState.spawning;
      animation = _animationManager.idleAnimation(gameRef, spriteSize);
      _treeSurfaceLandManager.setTreeSurfaceLandSpawnBounds();
      LogUtil.debug('TreeSurface sprite loaded succesfully');
      add(CircleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _treeSurfaceLandManager.checkTreeToLandGravity(dt, this);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

}