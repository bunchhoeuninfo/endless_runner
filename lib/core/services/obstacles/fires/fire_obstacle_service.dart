import 'dart:math';

import 'package:endless_runner/components/obstacles/fire_obstacle.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_animation_manager.dart';
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_manager.dart';
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_state_manager.dart';
import 'package:endless_runner/core/services/obstacles/fires/fire_obstacle_animation_service.dart';
import 'package:endless_runner/core/services/obstacles/fires/fire_obstacle_state_service.dart';
import 'package:endless_runner/core/state/fire_obstacle_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class FireObstacleService implements FireObstacleManager {

  final double _fallSpeed = 200;    // Speed of gold coin movement

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
  final FireObstacleAnimationManager _animationManager = FireObstacleAnimationService();
  final FireObstacleStateManager _obstacleStateManager = FireObstacleStateService();

  @override
  SpriteAnimation applyFireObstacleAnimationByState(EndlessRunnerGame gameRef, FireObstacle fireObstacle, Vector2 spriteSize) {
    FireObstacleState state = _obstacleStateManager.stateNotifier.value;
    LogUtil.debug('Fire obstacle state -> $state');
    try {
      if (state == FireObstacleState.idle) {
        return _animationManager.idleAnimation(gameRef, spriteSize);
      } else if (state == FireObstacleState.spawning) {
        return _animationManager.spawningAnimation(gameRef, spriteSize);
      }

      return _animationManager.idleAnimation(gameRef, spriteSize);
    } catch (e) { 
      LogUtil.error('Exception -> $e');
      return _animationManager.idleAnimation(gameRef, spriteSize);
    }
  }

  @override
  void checkFireObstacleGravity(double dt, FireObstacle fireObstacle) {
    try {
      fireObstacle.position.y += _fallSpeed * dt;
      _obstacleStateManager.stateNotifier.value = FireObstacleState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y - fireObstacle.size.y;
      if (fireObstacle.position.y > groundLevel) {
        _obstacleStateManager.stateNotifier.value = FireObstacleState.hitGround;
        fireObstacle.removeFromParent();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void setFireObstacleSpawnBounds(EndlessRunnerGame gameRef) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _minY = 0;
      _maxX = screenSize.x;
      _maxY = screenSize.y;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void spawnFireObstacle(EndlessRunnerGame gameRef, double dt) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _minY = 0;
      _maxX = screenSize.x;
      _maxY = screenSize.y;

      // Define number of columns and select one at random
      int totalColumns = 7;   // Assuming a 4-column layout
      int selectedColumn = _random.nextInt(totalColumns);

      // Calculate the X position of the selected column
      double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
      double columnX = _minX + (selectedColumn * columnSpacing);

      FireObstacle fireObstacle = FireObstacle(Vector2(columnX, _minY));
      gameRef.add(fireObstacle);

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}