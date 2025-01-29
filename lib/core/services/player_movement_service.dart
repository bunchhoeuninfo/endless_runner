import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/player_manager.dart';
import 'package:endless_runner/core/managers/player_movement_manager.dart';
import 'package:endless_runner/core/services/player_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerMovementService implements PlayerMovementManager {
  final PlayerManager _playerManager = PlayerService();
  final double _jumpForce = -400;
  final double _gravity = 600;
  final double _moveSpeed = 200; // Movement speed

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;

  late double _minX;
  late double _maxX;

  void setMovementBounds(EndlessRunnerGame gameRef) {
    _minX = gameRef.size.x * 0.1;
    _maxX = gameRef.size.x * 0.9;
  }

  @override
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef) {
    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
    }

    final groundLevel = gameRef.size.y / 2;
    const topLevel = 0.0;

    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
    }

    if (player.position.y < topLevel) {
      player.position.y = topLevel;
      _velocityY = 0;
    }

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
  }

  @override
  void moveRight() {
    _velocityX = _moveSpeed; // Move right
  }

  @override
  void stopMoving() {
    _velocityX = 0; // Stop movement
  }
  
  @override
  void resetPosition(EndlessRunnerGame gameRef, Player player) {
    //LogUtil.debug('Start inside resetPosition ...');
    //final screenLeftEdge = gameRef.size.x * 0.02;
    //final groundLevel = gameRef.size.y / 2;
    final screenLeftEdge = gameRef.size.x * 0.45;
    final groundLevel = gameRef.size.y / 2;


    player.position = Vector2(screenLeftEdge, groundLevel);
    _velocityY = 0;
    isGrounded = true;
  }
}
  /*
  //final EndlessRunnerGame gameRef;
  //final SpriteComponent player;
  final PlayerManager _playerManager = PlayerService();
  final double _jumpForce = -400;
  final double _gravity = 600;

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;


  @override
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef) {
    try {
      //LogUtil.debug('Start inside applyGravity ...');
      if (!isGrounded) {
        _velocityY += _gravity * dt;
        _velocityX += _gravity * dt;
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
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  @override
  void jump() {
    try {
      LogUtil.debug('Try to jump');
      if (isGrounded) {
        _velocityY = _jumpForce;
        isGrounded = false;
      } else {
        // Apply another jump force while in the air (mid-jump)
        _velocityY = _jumpForce;
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }        
  }

  @override
  void handleTap(Vector2 tapPosition, EndlessRunnerGame gameRef) {
    if (tapPosition.y < gameRef.size.y / 2) {
      jump();
    }
  }

  @override
  void resetPosition(EndlessRunnerGame gameRef, Player player) {
    //LogUtil.debug('Start inside resetPosition ...');
    //final screenLeftEdge = gameRef.size.x * 0.02;
    //final groundLevel = gameRef.size.y / 2;
    final screenLeftEdge = gameRef.size.x * 0.45;
    final groundLevel = gameRef.size.y / 2;


    player.position = Vector2(screenLeftEdge, groundLevel);
    _velocityY = 0;
    isGrounded = true;
  }
  
  @override
  void moveLeft() {
    try {
      LogUtil.debug('Try to move left');
      _velocityX = -_moveSpeed; // Move left by decreasing X velocity
    } catch (e) {
      LogUtil.error('Exception -> $e');
    } 
  }
  
  @override
  void moveRight() {
    // TODO: implement moveRight
  }
}*/