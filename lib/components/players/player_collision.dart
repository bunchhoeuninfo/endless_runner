import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/components/powerups/speed_boost_manager.dart';
import 'package:endless_runner/components/powerups/speed_boost_services.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerCollision {
  final EndlessRunnerGame gameRef;
  final SpriteComponent player;
  final SpeedBoostManager _speedBoostManager = SpeedBoostServices();

  PlayerCollision({required this.gameRef, required this.player});

  void handleCollision(PositionComponent other) {
    if (other is Obstacle) {
      LogUtil.debug('Game Over: Player collided with obstacle!');
      gameRef.gameOver();
    } else if (other is Coin) {
      LogUtil.debug('Player collected a coin!');      
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
    } else if (other is SpeedBoost) {
      LogUtil.debug('Speed Boost Activated.');
      double speedMultiplier = 2.0;
      _speedBoostManager.applySpeedBoost(speedMultiplier, gameRef);
      other.removeFromParent();
    }
  }
}