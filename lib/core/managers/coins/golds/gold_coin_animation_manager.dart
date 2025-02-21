import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';

abstract class GoldCoinAnimationManager {
  SpriteAnimation goldCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize);  
  SpriteAnimation spawnCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize);
  SpriteAnimation coinsCollectedAnimation(EndlessRunnerGame gameRef, Vector2 coinSize);
  SpriteAnimation idleGoldCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize);
}