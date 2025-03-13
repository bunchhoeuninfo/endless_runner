import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_manager.dart';
import 'package:endless_runner/core/services/backgrounds/grids/grid_background_services.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GridBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  GridBackground({super.key});

  double speed = 0;
  late SpriteComponent bg1;
  late SpriteComponent bg2;
  double moveSpeed = 0; // Start with 0, change when player moves up
  double maxSpeed = 200; // Adjust the speed when moving up
  final GridBackgroundManager _gridBackgroundManager = GridBackgroundServices();
  final _gridBackgroundSize = Vector2(400, 800);
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
     
    final bgSprite = await gameRef.loadSprite('backgrounds/grid_bg.png');

    bg1 = SpriteComponent(
      sprite: bgSprite,
      size: gameRef.size,
      position: Vector2(0, 0),
    );

    bg2 = SpriteComponent(
      sprite: bgSprite,
      size: gameRef.size,
      position: Vector2(0, -gameRef.size.y), // Place second background above the first
    );

    addAll([bg1, bg2]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Move backgrounds based on player's movement speed
    bg1.y += moveSpeed * dt;
    bg2.y += moveSpeed * dt;

    // Infinite loop for background
    if (bg1.y >= gameRef.size.y) {
      bg1.y = bg2.y - gameRef.size.y;
    }
    if (bg2.y >= gameRef.size.y) {
      bg2.y = bg1.y - gameRef.size.y;
    }
  }

  // This function is called when the player moves up
  void moveUp() {
    moveSpeed = -maxSpeed; // Move background downward when player moves up
  }

  // Stop moving when the player stops moving up
  void stopMoving() {
    moveSpeed = 0;
  }
   
}