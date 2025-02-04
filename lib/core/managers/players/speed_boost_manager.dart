
import 'package:endless_runner/game/endless_runner_game.dart';

abstract class SpeedBoostManager {
  void spawnSpeedBoostCoin(EndlessRunnerGame game);
  void applySpeedBoost(double boostMultiplier, EndlessRunnerGame game);
}