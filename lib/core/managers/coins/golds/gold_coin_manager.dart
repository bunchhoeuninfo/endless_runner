import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/game/endless_runner_game.dart';

abstract class GoldCoinManager {
  void spawnGoldCoins(EndlessRunnerGame gameRef);
  void spanwGoldCoinsDownward(EndlessRunnerGame gameRef,  GoldCoin goldCoin, double dt);
  void handleGoldCoinsCollected(EndlessRunnerGame gameRef);
  
  void setGoldCoinSpawnBounds(EndlessRunnerGame gameRef);
  void removeGoldCoins(EndlessRunnerGame gameRef, GoldCoin goldCoin);
}