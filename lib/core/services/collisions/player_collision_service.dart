import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/obstacles/car_obstacle.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/obstacles/road_cone_obstacle.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/collisions/player_collision_manager.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/managers/players/speed_boost_manager.dart';
import 'package:endless_runner/core/services/players/speed_boost_services.dart';
import 'package:endless_runner/core/services/scores/live_score_service.dart';
import 'package:endless_runner/core/managers/games/game_service_manager.dart';
import 'package:endless_runner/core/services/games/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerCollisionService implements PlayerCollisionManager {
  //final EndlessRunnerGame gameRef;
  //final SpriteComponent player;
  final SpeedBoostManager _speedBoostManager = SpeedBoostServices();
  final GameServiceManager _gameServiceManager = GameServiceService();
  final LiveScoreService _liveScoreService = LiveScoreService();

  @override
  void handleCollision(PositionComponent other, EndlessRunnerGame gameRef) {
    takeAction(other, gameRef);
  }

  void takeAction(PositionComponent other, EndlessRunnerGame gameRef) {
    if (other is Obstacle) {
      LogUtil.debug('Game Over: Player collided with obstacle!');
      _gameServiceManager.gameOver(gameRef);
      other.removeFromParent();
    } else if (other is Coin) {
      //LogUtil.debug('Player collected a coin!');      
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
      other.removeFromParent();   //Remove the coin after collection
    } else if (other is SpeedBoost) {
      //LogUtil.debug('Speed Boost Activated.');
      double speedMultiplier = 5.0;
      _speedBoostManager.applySpeedBoost(speedMultiplier, gameRef);
      other.removeFromParent();
    } else if (other is CarObstacle) {
      //LogUtil.debug('Game Over: Player collided with car obstacle!');
      _gameServiceManager.gameOver(gameRef);
      other.removeFromParent();
    } else if (other is RoadConeObstacle) {
      //LogUtil.debug('Game Over: Player collided with road cone obstacle!');
      _gameServiceManager.gameOver(gameRef);
      other.removeFromParent();
    }

    // Check if player has leveled up
    _liveScoreService.listentoLevel((newLevel) {
      //LogUtil.debug('Player leveled up to $newLevel');
      _gameServiceManager.levelUp(gameRef);
      //_liveScoreService.levelNotifier.value = newLevel;
    });
  }

  @override
  Player singlePlayer(EndlessRunnerGame game) {
    late Player player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
    //late Player player = Player();
    try {
      LogUtil.debug('Try to initialize player');
      player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
      //player = Player();
      return player;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    return player;
  }
  
  @override
  void handleObstacleCollision(PositionComponent other, EndlessRunnerGame gameRef) {
    if (other is CarObstacle) {
      LogUtil.debug('Game Over: Player collided with car obstacle!');
      _gameServiceManager.gameOver(gameRef);
    }
  }
}