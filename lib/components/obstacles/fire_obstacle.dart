
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_manager.dart';
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_state_manager.dart';
import 'package:endless_runner/core/services/obstacles/fires/fire_obstacle_service.dart';
import 'package:endless_runner/core/services/obstacles/fires/fire_obstacle_state_service.dart';
import 'package:endless_runner/core/state/fire_obstacle_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FireObstacle extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {

  FireObstacle(Vector2 position)
    : super(position: position, size: Vector2(50, 55));

  final FireObstacleManager _fireObstacleManager = FireObstacleService();
  final FireObstacleStateManager _obstacleStateManager = FireObstacleStateService();
  final _fireObstacleSize = Vector2(50, 55);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load fire obstacle sprite');

      _obstacleStateManager.stateNotifier.value = FireObstacleState.spawning;
      _fireObstacleManager.setFireObstacleSpawnBounds(gameRef);
      animation = _fireObstacleManager.applyFireObstacleAnimationByState(gameRef, this, _fireObstacleSize);

      add(CircleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _fireObstacleManager.checkFireObstacleGravity(dt, this);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
}