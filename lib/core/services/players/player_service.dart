import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/managers/players/player_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class PlayerService implements PlayerManager {  

  late Player _player;

  @override
  Player singlePlayer(EndlessRunnerGame game) {
    /*
    try {
      // Log initialization
      //LogUtil.debug('Try to initialize player');

      // Set player position at the center of the bottom
      _player = Player(
        position: Vector2(
          game.size.x / 2, // Center horizontally
          game.size.y - _player.height, // Bottom of the screen, subtracting player's height
        ),
      );

      return _player;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }

    return _player; // Return the player, even if it wasn't updated*/
    
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