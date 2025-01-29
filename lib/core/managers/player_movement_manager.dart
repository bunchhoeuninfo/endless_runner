import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class PlayerMovementManager {
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef);
  void jump();
  //void handleTap(Vector2 tapPosition, EndlessRunnerGame gameRef);
  void resetPosition(EndlessRunnerGame gameRef, Player player);
  void moveLeft();
  void moveRight();
  void stopMoving();
  

}