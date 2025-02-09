import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/players/player_movement_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerMovementService implements PlayerMovementManager {
  final double _jumpForce = -400;
  final double _upwardForce = -400;
  final double _gravity = 600;
  final double _moveSpeed = 500; // Movement speed

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;

  bool _deceleratingLeft = false;
  bool _deceleratingRight= false;
  bool _decelerating = false;

  late double _minX;
  late double _maxX;

  @override
  void setMovementBounds(EndlessRunnerGame gameRef) {
    _minX = gameRef.size.x * 0.05;
    _maxX = gameRef.size.x * 0.89;
  }

  

  @override
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef) {
    //LogUtil.debug('Called here position');
    final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    const topLevel = 0.0;

    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
      
    }

    //final groundLevel = gameRef.size.y / 2;
    

    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
    }

    // Present player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel;
      _velocityY = 0;
    }

    //LogUtil.debug('Player Y: ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');

    if (_decelerating) {
      LogUtil.debug('_decelerating->$_decelerating, _velocityX->$_velocityX');
      const double friction = 2500; // Adjust for smooth stopping effect
      if (_velocityX < 0) {
        _velocityX += friction * dt; // Gradually increase velocity towards 0
        if (_velocityX > 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      } else {
        _velocityX -= friction * dt; // Gradually decrease velocity towards 0
        if (_velocityX < 0) {
          _velocityX = 0; // Stop completely
          _decelerating = false;
        }
      }
    }

    //LogUtil.debug('_velocityX->$_velocityX');
    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    player.position.x = player.position.x.clamp(_minX, _maxX);
  }

  @override
  void jump() {
    if (isGrounded) {
      _velocityY = _jumpForce;
      isGrounded = false;
    }
  }

  @override
  void moveLeft() {
    _velocityX = -_moveSpeed; // Move left
    _decelerating = false;
  }

  @override
  void moveRight() {
    _velocityX = _moveSpeed; // Move right
    _decelerating = false;
  }

  @override
  void stopMoving() {
    _velocityX = 0; // Stop movement
  }
  
  @override
  void resetPosition(EndlessRunnerGame gameRef, Player player) {
    LogUtil.debug('Try to reset player position');
    final screenX = gameRef.size.x * 0.5;
    final groundLevel = gameRef.size.y / 2;
    //player.position.x = screenLeftEdge;
    player.position = Vector2(screenX, groundLevel);
    _velocityY = 0;
    _velocityX = 0;
    isGrounded = true;
    //player.position.x += _velocityX * dt;
    //player.position.x = player.position.x.clamp(_minX, _maxX);
    LogUtil.debug('Try to reset player position ${player.position.y}, VelocityY: $_velocityY, Grounded: $isGrounded');
  }

  @override
  void onLeftTapUp() {
    // When the user lifts their finger, set _velocityX to 0, stopping movement.
    //_velocityX = 0;  // Stop moving when the tap is released
    _decelerating = true;
  }
  
  
  @override
  void onRighttapUp() {
    //top gradually when the tap is released
    _decelerating = true;
  }
  
  @override
  void initPosition(EndlessRunnerGame gameRef, Player player) {
    final screenLeftEdge = gameRef.size.x * 0.5;
    final groundLevel = gameRef.size.y / 2;
    player.position = Vector2(screenLeftEdge, groundLevel);
    _velocityY = 0;
    isGrounded = true;
  }
  
  @override
  void moveUpward() {
    _velocityY = _upwardForce;
    isGrounded = false;
  }

  
  
}