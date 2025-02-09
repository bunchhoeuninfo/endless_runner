
import 'package:endless_runner/core/managers/collisions/player_collision_manager.dart';
import 'package:endless_runner/core/services/collisions/player_collision_service.dart';
import 'package:endless_runner/core/managers/players/player_movement_manager.dart';
import 'package:endless_runner/core/services/players/player_movement_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks, GestureHitboxes   {



  Player({required Vector2 position})
      : super(size: Vector2(50, 50), position: position); // Fixed position

  final double moveSpeed = 200;
  final double jumpForce = -400;
  final double gravity = 600;
  double velocityY = 0;
  bool isGrounded = false;

  final PlayerMovementManager _playerMovement = PlayerMovementService();
  final PlayerCollisionManager _playerCollisionManager = PlayerCollisionService();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Inside Player.onLoad method...');
    try {

      //sprite = await gameRef.loadSprite('rock.jpg'); // Load the player sprite
      
      sprite = Sprite(gameRef.images.fromCache('rock.jpg'));
      LogUtil.debug('Player sprite loaded succesfully');

      //_playerMovement = PlayerMovement(gameRef: gameRef, player: this);
      //_collisionHandler = PlayerCollision(gameRef: gameRef, player: this);

       paint = Paint()..color = Colors.blue;
      // set initial position
      _playerMovement.setMovementBounds(gameRef);
      //_playerMovement.resetPosition(gameRef, this);

      add(RectangleHitbox());
      priority = 100;
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);    
    //_collisionHandler.handleCollision(other);
    //_playerCollisionManager.handleObstacleCollision(other, gameRef);
    _playerCollisionManager.handleCollision(other, gameRef);
  }

  void jump() {
    LogUtil.debug('Called jump method...');
    _playerMovement.jump();
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

  @override
  void update(double dt) {
    //LogUtil.debug('Called update method...');
    super.update(dt);

    _playerMovement.applyGravity(dt, this, gameRef);
  }

  void initPosition() {
    _playerMovement.initPosition(gameRef, this);
  }


  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Called handleTap method...');
    //_playerMovement.handleTap(tapPosition, gameRef);
  }

}