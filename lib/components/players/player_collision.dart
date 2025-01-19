import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/player_manager.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/managers/speed_boost_manager.dart';
import 'package:endless_runner/core/services/speed_boost_services.dart';
import 'package:endless_runner/core/services/live_score_service.dart';
import 'package:endless_runner/core/managers/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerCollision implements PlayerManager {
  final EndlessRunnerGame gameRef;
  final SpriteComponent player;
  final SpeedBoostManager _speedBoostManager = SpeedBoostServices();
  final GameServiceManager _gameServiceManager = GameServiceService();
  final LiveScoreService _liveScoreService = LiveScoreService();

  PlayerCollision({required this.gameRef, required this.player});

  void handleCollision(PositionComponent other) {
    if (other is Obstacle) {
      LogUtil.debug('Game Over: Player collided with obstacle!');
      _gameServiceManager.gameOver(gameRef);
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
      //LogUtil.debug('Collected coin score: $pointToAdd');
      _liveScoreService.updateScore(pointToAdd);
      other.removeFromParent();   //Remove the coin after colleciton
    } else if (other is SpeedBoost) {
      LogUtil.debug('Speed Boost Activated.');
      double speedMultiplier = 5.0;
      _speedBoostManager.applySpeedBoost(speedMultiplier, gameRef);
      other.removeFromParent();
    }
  }

  @override
  Player singlePlayer(EndlessRunnerGame game) {
    late Player player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
    try {
      LogUtil.debug('Try to initialize player');
      player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
      return player;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    return player;
  }
}