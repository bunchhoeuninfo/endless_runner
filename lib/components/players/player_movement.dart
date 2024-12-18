import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerMovement {
  final EndlessRunnerGame gameRef;
  final SpriteComponent player;
  final double _jumpForce = -400;
  final double _gravity = 600;
  final String _className = 'PlayerMovement';

  double _velocityY = 0;
  bool isGrounded = false;

  PlayerMovement({required this.gameRef, required this.player});

  void applyGravity(double dt) {
    LogUtil.debug('Start inside $_className.applyGravity ...');
    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
    }

    // Ground level and screen boundaries
    final groundLevel = gameRef.size.y / 2;
    const topLevel = 0.0;

    // Prevent going below ground level
    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
    }

    // Prevent going above the screen
    if (player.position.y < topLevel) {
      player.position.y = topLevel;
      _velocityY = 0;
    }
  }

  void jump() {
    LogUtil.debug('Start $_className.jump ...');
    if (isGrounded) {
      _velocityY = _jumpForce;
      isGrounded = false;
    } else {
      // Apply another jump force while in the air (mid-jump)
      _velocityY = _jumpForce;
    }
  }

  void handleTap(Vector2 tapPosition) {
    if (tapPosition.y < gameRef.size.y / 2) {
      jump();
    }
  }

  void resetPosition() {
    LogUtil.debug('Start inside resetPosition ...');
    final screenLeftEdge = gameRef.size.x * 0.02;
    final groundLevel = gameRef.size.y / 2;

    player.position = Vector2(screenLeftEdge, groundLevel);
    _velocityY = 0;
    isGrounded = true;
  }
}