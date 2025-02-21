

import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoadConeObstacle extends SpriteComponent with HasGameRef<EndlessRunnerGame> {

  double _fallSpeed = 200;  // Speed of obstacle move downward
  
  RoadConeObstacle({required Vector2 position})
    : super(
      position: position,
      size: Vector2(50, 50)   // Obstacle size
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    try {
      sprite = await gameRef.loadSprite('obstacles/road_cone.png');
      add(CircleHitbox());
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += _fallSpeed * dt;
    
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  void resetState() {
    position.y = 0; // Reset position
    _fallSpeed = 200;
  }

   @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

}