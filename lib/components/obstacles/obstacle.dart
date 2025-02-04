import 'dart:ui';

import 'package:endless_runner/core/managers/players/player_manager.dart';
import 'package:endless_runner/core/services/players/player_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';

import 'package:flame/components.dart';

class Obstacle extends SpriteComponent  with HasGameRef<EndlessRunnerGame> {
  double speed = 200; // Speed of obstacle movement
  final String className = 'Obstacle';
  bool hasScored = false;   // Flag to check if the score has been updated
  final PlayerManager _playerManager = PlayerService();

  Obstacle({required Vector2 position})
      : super(
          position: position,
          size: Vector2(50, 50), // Obstacle size
        );

  @override
  Future<void> onLoad() async {
    LogUtil.debug('Start inside $className.onload...');
    try {
      sprite = await gameRef.loadSprite('rock.jpg'); // Load obstacle sprite
      add(RectangleHitbox());  // Add hitbox for collision detection
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }    
  }

  @override
  void update(double dt) {
    super.update(dt);
    //LogUtil.debug('Start inside $className.update...');
    // Move the obstacle to the left
    position.x -= speed * dt;

    if (!hasScored && position.x + size.x < _playerManager.singlePlayer(game).position.x) {
      hasScored = true; // Mark as scored
      //gameRef.increaseScore();
    }

    // Remove obstacle if it moves off-screen
    if (position.x < -size.x) {
      //LogUtil.debug('Start inside $className.update...Removed obstacle here');
      removeFromParent();
    }
  }

  // Method to reset obstacle state
  void resetState() {
    // Reset any properties related to the obstacle
    position.x = 0;  // Reset position
    speed = 5.0;  // Reset speed to initial value
    // Reset any animations or special states
  }

  @override
  Rect toRect() {
    super.toRect();
    return Rect.fromLTWH(position.x, position.y, 50, 50);  // Example obstacle size (50x50)
  }

}