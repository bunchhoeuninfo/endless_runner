

/*

class Player extends SpriteComponent with HasGameRef<EndlessRunnerGame>, CollisionCallbacks, GestureHitboxes   {

  Player({required Vector2 position})
      : super(size: Vector2(50, 50), position: position, anchor: Anchor.center); // Fixed position

  final String className = 'Player';
  final double moveSpeed = 200;
  final double jumpForce = -400;
  final double gravity = 600;
  double velocityY = 0;
  bool isGrounded = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Inside Player.onLoad method...');
    try {
      LogUtil.debug('Player position: $position');
      LogUtil.debug('Game size in player: ${gameRef.size}');
      sprite = await gameRef.loadSprite('player_1.png'); // Load the player sprite
      LogUtil.debug('Player sprite loaded succesfully');

      // Center the player horizontally and position near the ground
      final screenLeftEdge = gameRef.size.x * 0.5;
      final groundLevel = gameRef.size.y / 2;

      position = Vector2(screenLeftEdge, groundLevel); // Center horizontally, start at ground level
      isGrounded = true;

      LogUtil.debug('Player position on load: $position');
      LogUtil.debug('Game screen size: ${gameRef.size}');

      add(RectangleHitbox());

    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace',);
    }    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {    
    super.onCollision(intersectionPoints, other);

    LogUtil.debug('Start inside $className.onCollision.');

    if (other is Obstacle) {      
      LogUtil.debug('Game Over: Player collided with obstacle!');      
      gameRef.gameOver();
    }
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
    if (isGrounded) {
      velocityY = jumpForce;
      isGrounded = false;
    } else {
      // Apply another jump force while in the air (mid-jump)
      velocityY = jumpForce;
    }
  }

  @override
  void update(double dt) {
    LogUtil.debug('Called $className.update method...');
    super.update(dt);

    // Apply gravity only if the player is not on the ground
    if (!isGrounded) {
      velocityY += gravity * dt;
      position.y += velocityY * dt;
    }

    const topLevel = 0.0;
    //check if the player is grounded
    final groundLevel = gameRef.size.y / 2;
    if (position.y >= groundLevel) {
      position.y = groundLevel;
      velocityY = 0;
      isGrounded = true;
    }

    // Prevent the player from going above the screen (top boundary)
    if (position.y < topLevel) {
      position.y = topLevel;  // Lock the player to the top of the screen
      velocityY = 0; // Stop any upward velocity
    }
  }


  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Called $className.handleTap method...');
    if (tapPosition.y < gameRef.size.y / 2) {
      jump();
    }
  }

}*/