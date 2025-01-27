
import 'package:endless_runner/components/players/player_collision.dart';
import 'package:endless_runner/core/managers/player_movement_manager.dart';
import 'package:endless_runner/core/services/player_movement_service.dart';
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

  late PlayerMovementManager _playerMovement = PlayerMovementService();
  late PlayerCollision _collisionHandler;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Inside Player.onLoad method...');
    try {

      //sprite = await gameRef.loadSprite('rock.jpg'); // Load the player sprite
      
      sprite = Sprite(gameRef.images.fromCache('rock.jpg'));
      LogUtil.debug('Player sprite loaded succesfully');

      //_playerMovement = PlayerMovement(gameRef: gameRef, player: this);
      _collisionHandler = PlayerCollision(gameRef: gameRef, player: this);

       paint = Paint()..color = Colors.blue;
      // set initial position
      //_playerMovement.resetPosition();

      add(RectangleHitbox());
      priority = 100;
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);    
    _collisionHandler.handleCollision(other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint);
  }

  void resetPosition() {
    //LogUtil.debug('Called reset player object position...');
    final screenLeftEdge = gameRef.size.x * 0.02;
    final groundLevel = gameRef.size.y / 2;

    position = Vector2(screenLeftEdge, groundLevel);
    velocityY = 0;
    isGrounded = true;
    //LogUtil.debug('Reset player object position is completed...');
  }

  void jump() {
    LogUtil.debug('Called jump method...');
    _playerMovement.jump();
  }

  @override
  void update(double dt) {
    //LogUtil.debug('Called update method...');
    super.update(dt);

    _playerMovement.applyGravity(dt);
  }


  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Called handleTap method...');
    _playerMovement.handleTap(tapPosition);
  }

}