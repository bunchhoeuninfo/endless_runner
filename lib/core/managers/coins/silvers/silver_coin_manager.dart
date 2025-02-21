import 'package:endless_runner/components/coins/silver_coin.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class SilverCoinManager {
  void spawnSilverCoinDownward(EndlessRunnerGame gameRef, double dt);
  void setSilverCoinSpawnBounds(EndlessRunnerGame gameRef);
  void checkSilverCoinGravity(double dt, SilverCoin silvercoin);
  SpriteAnimation applySilverCoinAnimationByState(EndlessRunnerGame gameRef, SilverCoin silverCoin, Vector2 spriteSize);
}