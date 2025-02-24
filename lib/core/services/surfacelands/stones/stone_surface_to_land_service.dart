import 'dart:math';

import 'package:endless_runner/components/surfacetoland/stone_surface_to_land.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_animation_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/services/surfacelands/stones/stone_surface_to_land_animation_service.dart';
import 'package:endless_runner/core/services/surfacelands/stones/stone_surface_to_land_state_service.dart';
import 'package:endless_runner/core/state/stone_surface_to_land_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class StoneSurfaceToLandService implements StoneSurfaceToLandManager {

  final double _fallSpeed = 100;    // Speed of stone surface  movement

  bool isGrounded = false;
  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final Random _random = Random();
  final StoneSurfaceToLandAnimationManager _animationManager = StoneSurfaceToLandAnimationService();
  final StoneSurfaceToLandStateManager _stateManager = StoneSurfaceToLandStateService();



  @override
  SpriteAnimation applyStoneSurfaceToLandAnimationByState(EndlessRunnerGame gameRef, StoneSurfaceToLand stoneSurfaceToLand, Vector2 spriteSize) {
    StoneSurfaceToLandState state = _stateManager.stateNotifier.value;
    LogUtil.debug('Stone surface to land state -> $state');
    try {
      if (state == StoneSurfaceToLandState.idle) {
        return _animationManager.idleAnimation(gameRef, spriteSize);
      }  else if (state == StoneSurfaceToLandState.spawning) {
        return _animationManager.spawningAnimation(gameRef, spriteSize);
      }

      return _animationManager.idleAnimation(gameRef, spriteSize);
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _animationManager.idleAnimation(gameRef, spriteSize);
    }
  }

  @override
  void checkStoneSurfaceToLandGravity(double dt, StoneSurfaceToLand stoneSurfaceToLand) {
    try {
      stoneSurfaceToLand.position.y += _fallSpeed * dt;
      _stateManager.stateNotifier.value = StoneSurfaceToLandState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y - stoneSurfaceToLand.size.y;
      if (stoneSurfaceToLand.position.y > groundLevel) {
        _stateManager.stateNotifier.value = StoneSurfaceToLandState.hitGround;
        stoneSurfaceToLand.removeFromParent();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

  }


  @override
  void setStoneSurfaceToLandBounds(EndlessRunnerGame gameRef) {
    
    try {
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
  void spawnStoneSurfaceToLand(EndlessRunnerGame gameRef, double dt) {
    
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0; 
      _maxY = screenSize.y;

      // Define number of columns an select one at random
      int totalColumns = 5;   // Assuming a 5-column layout
      int selectedColumn = _random.nextInt(totalColumns);  // Pick a column randomly

      // Calculate the X position of the selected column
      double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
      double columnX = _minX + (selectedColumn * columnSpacing);

      StoneSurfaceToLand stoneSurfaceToLand = StoneSurfaceToLand(Vector2(columnX, _minY));
      gameRef.add(stoneSurfaceToLand);
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
 }