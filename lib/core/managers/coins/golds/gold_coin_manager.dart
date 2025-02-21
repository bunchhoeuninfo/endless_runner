import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class GoldCoinManager {
  void spawnGoldCoins(EndlessRunnerGame gameRef);
  void spawnGoldCoinsDownward(EndlessRunnerGame gameRef, double dt);
  void handleGoldCoinsCollected(EndlessRunnerGame gameRef);
  
  void setGoldCoinSpawnBounds(EndlessRunnerGame gameRef);
  void removeGoldCoins(EndlessRunnerGame gameRef, GoldCoin goldCoin);
  void checkGoldCoinGravity(double dt, GoldCoin goldCoin);
  SpriteAnimation applyGoldCoinAnimationByState(EndlessRunnerGame gameRef, GoldCoin goldCoin, Vector2 spriteSize);
}