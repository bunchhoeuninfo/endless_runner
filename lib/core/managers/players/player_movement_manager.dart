import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

abstract class PlayerMovementManager {
  
  // Apply gravity to the player
  void applyGravityHorizontal(double dt, Player player, EndlessRunnerGame gameRef);
  void applyGravityVertical(double dt, Player player, EndlessRunnerGame gameRef);
  void applyGravity(double dt, Player player, EndlessRunnerGame gameRef);

  void jump();
  //void handleTap(Vector2 tapPosition, EndlessRunnerGame gameRef);
  void resetPosition(EndlessRunnerGame gameRef, Player player);
  void initPosition(EndlessRunnerGame gameRef, Player player);
  
  // set the movement bounds for the player
  void setMovementBoundsHorizontal(EndlessRunnerGame gameRef);
  void setMovementBoundsVertical(EndlessRunnerGame gameRef);
  void setMovementBounds(EndlessRunnerGame gameRef);


  void moveUpward();

  void moveLeft();
  void moveRight();
  void stopMoving();

  void onLeftTapUp();

  void onRighttapUp();

 

}