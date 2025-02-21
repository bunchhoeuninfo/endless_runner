import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/players/player_movement_manager.dart';
import 'package:endless_runner/core/managers/players/player_state_manager.dart';
import 'package:endless_runner/core/services/players/player_state_service.dart';
import 'package:endless_runner/core/state/player_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerMovementService implements PlayerMovementManager {
  final double _jumpForce = -250;
  final double _upwardForce = -400;
  final double _gravity = 600;
  final double _moveSpeed = 500; // Movement speed
  final double _initGameSpeed = 100;

  double _velocityY = 0;
  double _velocityX = 0;
  bool isGrounded = false;

  bool _decelerating = false;


  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final PlayerStateManager _playerStateManager = PlayerStateService();

  @override
  void setMovementBoundsHorizontal(EndlessRunnerGame gameRef) {
    _minX = gameRef.size.x * 0.05;
    _maxX = gameRef.size.x * 0.89;
  }

  @override
  void applyGravityHorizontal(double dt, Player player, EndlessRunnerGame gameRef) {
    //LogUtil.debug('Called here position');
    final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    const topLevel = 0.0;

    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
      
    }    
    
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
    
      if (_playerStateManager.stateNotifier.value != PlayerState.jumping) {
        _playerStateManager.stateNotifier.value = PlayerState.jumping;
      }

      isGrounded = false;
    }
  }

  @override
  void moveLeft() {
    if (_playerStateManager.stateNotifier.value != PlayerState.moveLeft) {
      _playerStateManager.stateNotifier.value = PlayerState.moveLeft;
    }

    _velocityX = -_moveSpeed; // Move left
    _velocityY = 0;
    isGrounded = true;
    _decelerating = false;
  }

  @override
  void moveRight() {
    if (_playerStateManager.stateNotifier.value != PlayerState.moveRight) {
      _playerStateManager.stateNotifier.value = PlayerState.moveRight;
    }

    _velocityX = _moveSpeed; // Move right
    _velocityY = 0;
    isGrounded = true;
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
  
  @override
  void setMovementBoundsVertical(EndlessRunnerGame gameRef) {
    _minY = gameRef.size.y * 0.05;  // 5% from the top
    _maxY = gameRef.size.y * 0.89;  // 89% from the top (leaving space at the bottom)
  }
  
  @override
  void applyGravityVertical(double dt, Player player, EndlessRunnerGame gameRef) {
    //LogUtil.debug('Called here position');
    final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    const topLevel = 0.0;

    if (!isGrounded) {
      _velocityY += _gravity * dt;
      player.position.y += _velocityY * dt;
      
    }    
    
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
    player.position.y = player.position.y.clamp(_minY, _maxY);
  }
  
  @override
  Future<void> setMovementBounds(EndlessRunnerGame gameRef) async {
    try {
      Vector2 screenSize = _getScreenSize();
      await Future.delayed(const Duration(microseconds: 100), () {
        _minX = 0;  // Left edge of the screen        
        _maxX = screenSize.x - gameRef.player.size.x;  // Right edge of the screen        
        //LogUtil.debug('Player position _minX: $_minX, _maxX: $_maxX');
        _minY = 0;  // Top of the screen
        _maxY = screenSize.y;  // Bottom of the screen
      });
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  Vector2 _getScreenSize() {
    final Size screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    
    return Vector2(screenSize.width, screenSize.height);
  }
  
  @override
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef) {
    //LogUtil.debug('Called here position');
    //final groundLevel = gameRef.size.y / 2;// Move ground to bottom of the screen
    final groundLevel = _maxY - gameRef.player.size.y; // Move ground to bottom of the screen
    const topLevel = 0.0;
    const int currentLevel  = 1;
    

    if (!isGrounded) {
      _velocityY += _getGameSpeed(currentLevel) * dt;  // Accelerate downwards
      player.position.y += _velocityY * dt;  // Move player downwards
    }    
    
    // Check if the player has hit the ground
    if (player.position.y >= groundLevel) {
      player.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
      _playerStateManager.stateNotifier.value = PlayerState.idle;
    } else {
      isGrounded = false;   // Player is in the air
    }

    // Present player from going above the top boundary
    if (player.position.y < topLevel) {
      player.position.y = topLevel;  // Lock to the top
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

    // Move player and clamp within range
    player.position.x += _velocityX * dt;
    //LogUtil.debug('Player position before clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');

    // Ensure the player stays within the screen bounds
    player.position.x = player.position.x.clamp(_minX, _maxX);
    //LogUtil.debug('Player position after clamp x: ${player.position.x}, maxX: $_maxX, minX: $_minX');
    player.position.y = player.position.y.clamp(_minY, _maxY);

  }  

  double _getGameSpeed(int level) {
    return 100 + (level * 20); // Adjust the speed increase per level
  }
  
}