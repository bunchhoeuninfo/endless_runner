
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

abstract class CoinManager {
  void spawnCoins(EndlessRunnerGame game);
  void spawnDownwardCoin(EndlessRunnerGame game);
  void spawnCoinDownward(EndlessRunnerGame gameRef, Coin coin, double dt);
  void checkCoinCollisions(Player player, EndlessRunnerGame game);
  void handleCoinsCollected(EndlessRunnerGame gameRef, Coin coin);
  void setCoinSpawnBounds(EndlessRunnerGame game);
  void removeCoins(EndlessRunnerGame gameRef);
}