import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RocketBooster extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks {
  RocketBooster(Vector2 position)
    :super (position: position, size: Vector2(35, 50));

  final _rocketBoosterSize = Vector2(35, 50);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    try {
      LogUtil.debug('Try to load rocket booter sprite');

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }
}