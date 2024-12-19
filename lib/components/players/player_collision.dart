import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerCollision {
  final EndlessRunnerGame gameRef;
  final SpriteComponent player;

  PlayerCollision({required this.gameRef, required this.player});

  void handleCollision(PositionComponent other) {
    if (other is Obstacle) {
      LogUtil.debug('Game Over: Player collided with obstacle!');
      gameRef.gameOver();
    } else if (other is Coin) {
      LogUtil.debug('Player collected a coin!');
      // Increase score based on coin type
      int pointToAdd = 0;
      switch (other.type) {
        case CoinType.gold:
          pointToAdd = 10;
          break;
        case CoinType.red:
          pointToAdd = 8;
          break;
        case CoinType.blue:
          pointToAdd = 5;
          break;          
      }
      gameRef.addToCoinScore(pointToAdd);  // Add poin to coin score displaty
      gameRef.addToCoinCount(1);  // Increment coin count
      other.removeFromParent();   //Remove the coin after colleciton
    }
  }
}