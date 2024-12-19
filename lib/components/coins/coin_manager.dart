
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/endless_runner_game.dart';

abstract class CoinManager {
  void spawnCoins(EndlessRunnerGame game);
  void checkCoinCollisions(Player player, EndlessRunnerGame game);
}