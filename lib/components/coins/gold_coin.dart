

import 'package:endless_runner/core/managers/coins/golds/gold_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_service.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_state_service.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GoldCoin extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  

  GoldCoin(Vector2 position) : 
    super(position: position, size: Vector2(50, 50));

  final double _fallSpeed = 200;
  double velocityY = 0;
  bool isGrounded = false;
  double goldCoinTimer = 0;
  final double goldCoinSpawnInterval = 2.0; // Coin Spawn every 2 seconds
  final GoldCoinManager _goldCoinManager = GoldCoinService();
  final GoldCoinStateManager _goldCoinStateManager = GoldCoinStateService();

  final _goldCoinSize = Vector2(50, 50);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load gold coin sprite');
      _goldCoinStateManager.stateNotifier.value = GoldCoinState.spawning;
      _goldCoinManager.setGoldCoinSpawnBounds(gameRef);
      animation = _goldCoinManager.applyGoldCoinAnimationByState(gameRef, this, _goldCoinSize);
      add(CircleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _goldCoinManager.checkGoldCoinGravity(dt, this);
    //animation = _goldCoinManager.applyGoldCoinAnimationByState(gameRef, this, _goldCoinSize);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
  
}