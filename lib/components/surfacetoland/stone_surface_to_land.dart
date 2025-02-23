import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_manager.dart';
import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/services/surfacelands/stones/stone_surface_to_land_service.dart';
import 'package:endless_runner/core/services/surfacelands/stones/stone_surface_to_land_state_service.dart';
import 'package:endless_runner/core/state/stone_surface_to_land_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class StoneSurfaceToLand extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  StoneSurfaceToLand(Vector2 position) 
    : super(position: position, size: Vector2(100, 30));

  final _stoneSurfaceSize = Vector2(100, 30);
  final StoneSurfaceToLandManager _stoneToLadManager = StoneSurfaceToLandService();
  final StoneSurfaceToLandStateManager _stateManager = StoneSurfaceToLandStateService();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load stone surface sprite');
      _stateManager.stateNotifier.value = StoneSurfaceToLandState.spawning;
      _stoneToLadManager.setStoneSurfaceToLandBounds(gameRef);
      animation = _stoneToLadManager.applyStoneSurfaceToLandAnimationByState(gameRef, this, _stoneSurfaceSize);
      add(RectangleHitbox());
      priority = 100;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _stoneToLadManager.checkStoneSurfaceToLandGravity(dt, this);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
}