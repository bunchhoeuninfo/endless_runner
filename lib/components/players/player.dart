import 'package:endless_runner/components/players/player_collision.dart';
import 'package:endless_runner/components/players/player_movement.dart';
import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks, GestureHitboxes   {

  Player({required Vector2 position})
      : super(size: Vector2(50, 50), position: position, anchor: Anchor.center); // Fixed position

  final String className = 'Player';
  final double moveSpeed = 200;
  final double jumpForce = -400;
  final double gravity = 600;
  double velocityY = 0;
  bool isGrounded = false;

  late PlayerMovement movementHandler;
  late PlayerCollision collisionHandler;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Inside Player.onLoad method...');
    try {

      sprite = await gameRef.loadSprite('player_1.png'); // Load the player sprite
      LogUtil.debug('Player sprite loaded succesfully');

      movementHandler = PlayerMovement(gameRef: gameRef, player: this);
      collisionHandler = PlayerCollision(gameRef: gameRef, player: this);

      // set initial position
      movementHandler.resetPosition();

      add(RectangleHitbox());

    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);

    LogUtil.debug('Start inside $className.onCollision.');
    collisionHandler.handleCollision(other);
  }

  void resetPosition() {
    LogUtil.debug('Called reset player object position...');
    final screenLeftEdge = gameRef.size.x * 0.5;
    final groundLevel = gameRef.size.y / 2;

    position = Vector2(screenLeftEdge, groundLevel);
    velocityY = 0;
    isGrounded = true;
    LogUtil.debug('Reset player object position is completed...');
  }

  void jump() {
    LogUtil.debug('Called $className.jump method...');
    movementHandler.jump();
  }

  @override
  void update(double dt) {
    LogUtil.debug('Called $className.update method...');
    super.update(dt);

    movementHandler.applyGravity(dt);
  }


  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Called $className.handleTap method...');
    movementHandler.handleTap(tapPosition);
  }

}