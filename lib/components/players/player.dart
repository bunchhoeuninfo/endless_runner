
import 'package:endless_runner/core/managers/collisions/player_collision_manager.dart';
import 'package:endless_runner/core/managers/players/player_animation_manager.dart';
import 'package:endless_runner/core/managers/players/player_state_manager.dart';
import 'package:endless_runner/core/services/collisions/player_collision_service.dart';
import 'package:endless_runner/core/managers/players/player_movement_manager.dart';
import 'package:endless_runner/core/services/players/player_animation_service.dart';
import 'package:endless_runner/core/services/players/player_movement_service.dart';
import 'package:endless_runner/core/services/players/player_state_service.dart';
import 'package:endless_runner/core/state/player_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks, GestureHitboxes   {

  Player({required Vector2 position})
      : super(size: Vector2(90, 120), position: position); // Fixed position

  final double moveSpeed = 200;
  final double jumpForce = -400;
  final double gravity = 600;
  double velocityY = 0;
  bool isGrounded = false;
  bool isScreenVertical = true;

  final PlayerMovementManager _playerMovement = PlayerMovementService();
  final PlayerAnimationManager _playerAnimationManager = PlayerAnimationService();
  final PlayerCollisionManager _playerCollisionManager = PlayerCollisionService();
  final PlayerStateManager _playerStateManager = PlayerStateService();
  
  final spriteSize = Vector2(300,370);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Inside Player.onLoad method...');
    try {
      _playerStateManager.stateNotifier.value = PlayerState.idle;
      _playerMovement.setMovementBounds(gameRef);
      animation = _playerAnimationManager.idleAnimation(gameRef, spriteSize);
      LogUtil.debug('Player sprite loaded succesfully');

      add(CircleHitbox());
      priority = 100;
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);    
    _playerCollisionManager.handleCollision(other, gameRef);
  }

  void jump() {
    LogUtil.debug('Called jump method... player state: ${_playerStateManager.stateNotifier.value}');
    if (_playerStateManager.stateNotifier.value == PlayerState.jumping) {
      return ;
    }
    
    if (_playerStateManager.stateNotifier.value != PlayerState.jumping) {
      _playerMovement.jump();
      _playerStateManager.stateNotifier.value = PlayerState.jumping;
      animation = _playerAnimationManager.jumpingAnimation(gameRef, spriteSize);
    }
  }

  void moveLeft() {
    _playerMovement.moveLeft();
  }

  void moveRight() {
    _playerMovement.moveRight();
  }

  void onLeftTapUp() {
    _playerMovement.onLeftTapUp();
  }

  void onRighttapUp() {
    _playerMovement.onRighttapUp();
  }

  void resetPosition() {
    _playerMovement.resetPosition(gameRef, this);
  }

  void moveUpward() {
    LogUtil.debug('Called move up ward method, player state: ${_playerStateManager.stateNotifier.value}');
    _playerMovement.moveUpward();
    
    if (_playerStateManager.stateNotifier.value != PlayerState.upward) {
      _playerStateManager.stateNotifier.value = PlayerState.upward;
      animation = _playerAnimationManager.upwardAnimation(gameRef, spriteSize);
    }
  }

  @override
  void update(double dt) {
    //LogUtil.debug('Called update method...');
    super.update(dt);
    _playerMovement.applyGravity(dt, this, gameRef);
  }

  void initPosition() {
    _playerMovement.initPosition(gameRef, this);
  }

  void initBoundary() {
    _playerMovement.setMovementBounds(gameRef);
  }


  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Called handleTap method...');
    //_playerMovement.handleTap(tapPosition, gameRef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.red..style = PaintingStyle.stroke);
  }

}