import 'package:endless_runner/core/managers/players/player_manager.dart';
import 'package:endless_runner/core/services/players/player_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CarObstacle extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  double _fallSpeed = 200; // Speed of obstacle movement

  bool hasScored = false;   // Flag to check if the core has been updated
  final PlayerManager _playerManager = PlayerService();
  
  CarObstacle({required Vector2 position})
    : super(
      position: position, 
      size: Vector2(50, 50) // Obstacle size
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('CarObstacle onload method');
    try {
      sprite = await gameRef.loadSprite('rock.jpg');  // Load car obstacle sprite
      add(RectangleHitbox()); // Add hitbox for collision detection
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

  // Method to reset obstacle state
  void resetState() {
    // Reset any properties related to the obstacle
    position.x = 0;   // Reset position
    _fallSpeed = 5.0;    // Reset speed to initial value
    // Reset any animations or special states
  }

  @override
  Rect toRect() {
    super.toRect();
    return Rect.fromLTWH(position.x, position.y, 50, 50);  // Example obstacle size (50x50)
  }
}