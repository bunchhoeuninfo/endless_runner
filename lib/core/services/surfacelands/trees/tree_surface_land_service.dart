import 'dart:math';

import 'package:endless_runner/components/surfacetoland/tree_surface.dart';
import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_land_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TreeSurfaceLandService implements TreeSurfaceLandManager {

  final Random _random = Random();

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;

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
  void spawnTreeSurfaceLand(EndlessRunnerGame gameRef) {
    // Define the bottom range
    final groundLevel = _maxY;
    double spawnY = 0.0; // Start at the top of the screen
    double spawnX = _minX + _random.nextDouble() * (_maxX - _minX);
    TreeSurface treeSurface = TreeSurface(position: Vector2(spawnX, spawnY));
    gameRef.add(treeSurface);
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
  void applyGravity(double dt, TreeSurface TreeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement applyGravity
  }
  
  @override
  void handlePlayerLanding(PositionComponent player, TreeSurface treeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement handlePlayerLanding
  }
  
  @override
  void handlePlayerLandingWithBreakable(PositionComponent player, TreeSurface treeSurface, EndlessRunnerGame gameRef) {
    // TODO: implement handlePlayerLandingWithBreakable
  }
  
}