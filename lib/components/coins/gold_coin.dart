
import 'package:endless_runner/core/managers/coins/golds/gold_coin_animation_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_animation_service.dart';
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
    super(position: position, size: Vector2(90, 120));

  final double _fallSpeed = 200;
  double velocityY = 0;
  bool isGrounded = false;
  double goldCoinTimer = 0;
  final double goldCoinSpawnInterval = 2.0; // Coin Spawn every 2 seconds

  final GoldCoinAnimationManager _goldCoinAnimationManager = GoldCoinAnimationService();
  final GoldCoinManager _goldCoinManager = GoldCoinService();
  final GoldCoinStateManager _goldCoinStateManager = GoldCoinStateService();

  final _goldCoinSize = Vector2(300, 370);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load gold coin sprite');
      _goldCoinStateManager.stateNotifier.value = GoldCoinState.idle;
      _goldCoinManager.setGoldCoinSpawnBounds(gameRef);

      add(CircleHitbox());
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnGoldCoinByTimer(dt);
    _checkGoldCoinState();
  }

  void _spawnGoldCoinByTimer(double dt) {
    goldCoinTimer += dt;
    if (goldCoinTimer >= goldCoinSpawnInterval) {
      goldCoinTimer = 0;
      _goldCoinManager.spanwGoldCoinsDownward(gameRef, this, dt);
    }
  }

  void _checkGoldCoinState() {
    GoldCoinState state = _goldCoinStateManager.stateNotifier.value;
    if (state == GoldCoinState.idle) {
      animation = _goldCoinAnimationManager.idleGoldCoinAnimation(gameRef, _goldCoinSize);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
  
}