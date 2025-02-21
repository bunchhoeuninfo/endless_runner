import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/core/managers/coins/coin_animation_manager.dart';
import 'package:endless_runner/core/managers/coins/coin_manager.dart';
import 'package:endless_runner/core/managers/coins/coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/coin_animation_service.dart';
import 'package:endless_runner/core/services/coins/coin_services.dart';
import 'package:endless_runner/core/services/coins/coin_state_service.dart';
import 'package:endless_runner/core/state/coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Coin extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  final double _fallSpeed = 200;
  final CoinType type;

  Coin(Vector2 position, this.type)
    : super(position: position, size: Vector2(90, 120));

  double velocityY = 0;
  bool isGrounded = false;

  final CoinManager _coinManager = CoinServices();
  final CoinAnimationManager _coinAnimationManager = CoinAnimationService();
  final CoinStateManager _coinStateManager = CoinStateService();

  final coinSize = Vector2(300, 370);

  @override
  Future<void> onLoad() async {
    //LogUtil.debug('Start inside coin object onLoad...');
    super.onLoad();

    try {
      //sprite = await gameRef.loadSprite('coins/coin_flip.jpg');
      LogUtil.debug('Try to load coin sprite');

      _coinStateManager.stateNotifier.value = CoinState.idle;
      _coinManager.setCoinSpawnBounds(gameRef);

      // Load the appropriate sprite based on the coin type
      /*switch (type) {
        case CoinType.gold:
          sprite = Sprite(gameRef.images.fromCache('coins/gold.jpg'));
          break;
        case CoinType.red:
          sprite = Sprite(await gameRef.images.load('coins/red.jpg'));
          break;
        case CoinType.blue:
          sprite = Sprite(await gameRef.images.load('coins/blue.jpg'));
          break;
      }*/

      LogUtil.debug('Succesfully load coin $type');

      add(CircleHitbox());      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) { 
    //LogUtil.debug('Start inside $_className.update ...');
    super.update(dt);
    //_coinManager.spawnCoinDownward(gameRef, this, dt);
    _checkCoinState();
  }

  void _checkCoinState() {
    CoinState coinState = _coinStateManager.stateNotifier.value;
    if (coinState == CoinState.collected) {
      animation = _coinAnimationManager.coinsCollectedAnimation(gameRef, coinSize);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

}