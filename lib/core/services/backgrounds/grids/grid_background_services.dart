
import 'dart:math';

import 'package:endless_runner/components/backgrounds/grid_background.dart';
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_animation_manager.dart';
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_manager.dart';
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_state_manager.dart';
import 'package:endless_runner/core/services/backgrounds/grids/grid_background_animation_services.dart';
import 'package:endless_runner/core/services/backgrounds/grids/grid_background_state_service.dart';
import 'package:endless_runner/core/state/grid_background_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/utils/screen_utils.dart';
import 'package:flame/components.dart';


class GridBackgroundServices implements GridBackgroundManager {

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  // background sprite
  late SpriteComponent bg1;
  late SpriteComponent bg2;
  double moveSpeed = 0; // Start with 0, change when player moves up
  double maxSpeed = 200; // Adjust the speed when moving up

  final Random _random = Random();
  final GridBackgroundAnimationManager _gridBackgroundAnimationManager = GridBackgroundAnimationServices();
  final GridBackgroundStateManager _gridBackgroundState = GridBackgroundStateService();

  @override
  SpriteAnimation applyGridBackgroundAnimationByState(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize) {
    GridBackgroundState state = _gridBackgroundState.stateNotifier.value;
    LogUtil.debug('Grid background state -> $state');
    try {
      if (state == GridBackgroundState.idle) {
        return _gridBackgroundAnimationManager.loopingBackgroundAnimation(gameRef, spriteSize);
      }

      return _gridBackgroundAnimationManager.loopingBackgroundAnimation(gameRef, spriteSize);
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _gridBackgroundAnimationManager.loopingBackgroundAnimation(gameRef, spriteSize);
    }
  }

  @override
  void setGridBackgroundBounds(EndlessRunnerGame gameRef) {
    try {
      LogUtil.debug('Try to set bounds');
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;
      _maxY = screenSize.y;
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  Future<Sprite> loadGridBackgroundSprite(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize) async {
    try {
      LogUtil.debug('Try to loadGridBackgroundSprite ');
      final bgSprite = await gameRef.loadSprite('backgrounds/grid_bg_sheet.png');
      return await gameRef.loadSprite('backgrounds/grid_bg.png');
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Excepition -> $e');
    }
  }
  
  @override
  Future<List<SpriteComponent>> loadGridBgSpriteComponent(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize) async {

    List<SpriteComponent> spriteComponents = [];

    try {
      LogUtil.debug('Try to loadGridBgSpriteComponent');
      final bgSprite = await gameRef.loadSprite('backgrounds/grid_bg_sheet.png');
      bg1 = SpriteComponent(
        sprite: bgSprite,
        size: gameRef.size,
        position: Vector2(0, 0),
      );

      bg2 = SpriteComponent(
        sprite: bgSprite,
        size: gameRef.size,
        position: Vector2(0, -gameRef.size.y), // Place second background above the first
      );

      spriteComponents.addAll(([bg1, bg2]));

      
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Exception ->$e');
    }

    return spriteComponents;
  }
  
  @override
  void applyGridBgGravity(double dt, EndlessRunnerGame gameRef) {
    try {
      LogUtil.debug('Try to apply grid background gravity');

      // Move backgrounds based on player's movement speed
      bg1.y += moveSpeed * dt;
      bg2.y += moveSpeed * dt;

      // Infinite loop for background
      if (bg1.y >= gameRef.size.y) {
        bg1.y = bg2.y - gameRef.size.y;
      }

      if (bg2.y >= gameRef.size.y) {
        bg2.y = bg1.y - gameRef.size.y;
      }
    } catch (e) {
      LogUtil.error('Exception ->$e');
    }    
  }
  
  @override
  void moveBgDownward() {
    LogUtil.debug('Move grid background downward');
    moveSpeed = -maxSpeed;    // Move grid background downward when player moves up
  }
  
  @override
  void stopMoving() {
    LogUtil.debug('Stop moving grid background when the player stops moving up');
    moveSpeed = 0;
  }

}