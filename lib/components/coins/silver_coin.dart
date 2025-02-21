import 'package:endless_runner/core/managers/coins/silvers/silver_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/silvers/silver_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/silvers/silver_coin_service.dart';
import 'package:endless_runner/core/services/coins/silvers/silver_coin_state_service.dart';
import 'package:endless_runner/core/state/silver_coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class SilverCoin extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  SilverCoin(Vector2 position)
    : super(position: position, size: Vector2(30, 30));

  final SilverCoinManager _silverCoinManager = SilverCoinService();
  final SilverCoinStateManager _silverCoinStateManager = SilverCoinStateService();

  final _silverCoinSize = Vector2(30, 30);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load silver coin sprite');
      _silverCoinStateManager.stateNotifier.value = SilverCoinState.spawning;
      _silverCoinManager.setSilverCoinSpawnBounds(gameRef);
      animation = _silverCoinManager.applySilverCoinAnimationByState(gameRef, this, _silverCoinSize);
      add(CircleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    _silverCoinManager.checkSilverCoinGravity(dt, this);
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
}