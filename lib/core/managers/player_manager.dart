import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

abstract class PlayerManager {
  Player singlePlayer(EndlessRunnerGame game);
}