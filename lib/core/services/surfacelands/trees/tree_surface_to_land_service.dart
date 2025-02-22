import 'dart:math';

import 'package:endless_runner/components/surfacetoland/tree_surface_to_land.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/services/surfacelands/trees/tree_surface_to_land_state_service.dart';
import 'package:endless_runner/core/state/tree_surface_to_land_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TreeSurfaceToLandService implements TreeSurfaceToLandManager {

  final Random _random = Random();

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;

  final _fallSpeed = 200; 
  final TreeSurfaceToLandManager _treeSurfaceToLandManager = TreeSurfaceToLandService();
  final TreeSurfaceToLandStateManager _treeSurfaceToLandStateManager = TreeSurfaceToLandStateService();

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;


  @override
  void setTreeSurfaceLandSpawnBounds() {
    try {
      Vector2 screenSize = _getScreenSize();
      _minX = 0;  // Left of the screen
      _maxX = screenSize.x;  // Right edge of the screen
      _minY = 0;  // Top of the screen
      _maxY = screenSize.y;  // Bottom of the screen
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void spawnTreeSurfaceToLand(EndlessRunnerGame gameRef, double dt) {
    try {

      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0.0;
      _maxX = screenSize.x;
      _minY = 0.0;  // Start at the top of the screen
      _maxY = screenSize.y;

      double spawnY = 0.0; // Start at the top of the screen
      double spawnX = _minX + _random.nextDouble() * (_maxX - _minX);
      TreeSurfaceToLand treeSurface = TreeSurfaceToLand(position: Vector2(spawnX, spawnY));
      gameRef.add(treeSurface);
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  @override
  void spawnTreeSurfaceLandWithBreakable() {
    // TODO: implement spawnTreeSurfaceLandWithBreakable
  }

  @override
  void spawnTreeSurfaceLandWithCoin() {
    // TODO: implement spawnTreeSurfaceLandWithCoin
  }

  Vector2 _getScreenSize() {
    final Size screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    
    return Vector2(screenSize.width, screenSize.height);
  }

  @override
  void applyGravity(double dt, TreeSurfaceToLand TreeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement applyGravity
  }
  
  @override
  void handlePlayerLanding(PositionComponent player, TreeSurfaceToLand treeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement handlePlayerLanding
  }
  
  @override
  void handlePlayerLandingWithBreakable(PositionComponent player, TreeSurfaceToLand treeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement handlePlayerLandingWithBreakable
  }
  
  @override
  void checkTreeToLandGravity(double dt, TreeSurfaceToLand treeSurface) {
    try {
      treeSurface.position.y += _fallSpeed * dt;
      _treeSurfaceToLandStateManager.stateNotifier.value = TreeSurfaceToLandState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y- treeSurface.size.y;
      if (treeSurface.position.y > groundLevel) {
        _treeSurfaceToLandStateManager.stateNotifier.value = TreeSurfaceToLandState.hitGround;
        treeSurface.removeFromParent();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
}