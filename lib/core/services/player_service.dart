import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/player_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerService implements PlayerManager {  
  @override
  Player singlePlayer(EndlessRunnerGame game) {
    late Player player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
    try {
      //LogUtil.debug('Try to initialize player');
      player = Player(position: Vector2(game.size.x * 0.02, game.size.y / 2)); // Starting position
      return player;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    return player;
  }

}