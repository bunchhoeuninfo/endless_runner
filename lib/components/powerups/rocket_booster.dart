import 'package:endless_runner/core/managers/powerups/rocket_booster_manager.dart';
import 'package:endless_runner/core/managers/powerups/rocket_booster_state_manager.dart';
import 'package:endless_runner/core/services/powerups/rocket_booster_services.dart';
import 'package:endless_runner/core/services/powerups/rocket_booster_state_service.dart';
import 'package:endless_runner/core/state/rocket_booster_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RocketBooster extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  RocketBooster(Vector2 position)
    :super (position: position, size: Vector2(35, 70));

  final _rocketBoosterSize = Vector2(35, 70);
  final RocketBoosterStateManager _rocketBoosterStateManager = RocketBoosterStateService();
  final RocketBoosterManager _rocketBoosterManager = RocketBoosterServices();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load rocket booter sprite');
      _rocketBoosterStateManager.stateNotifier.value = RocketBoosterState.spawning;
      _rocketBoosterManager.setRocketBoosterSpawnBounds(gameRef,);
      animation = _rocketBoosterManager.applyRocketBoosterAnimationByState(gameRef, this, _rocketBoosterSize);

      add(CircleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _rocketBoosterManager.checkRocketBoosterGravity(dt, this);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
}