import 'package:endless_runner/game/endless_runner_game.dart';

abstract class ObstacleManager {
  void spawnObstacle(EndlessRunnerGame game);
  void spawnCarObstacle(EndlessRunnerGame game);
  void spawnRoadConeObstacle(EndlessRunnerGame game);
}