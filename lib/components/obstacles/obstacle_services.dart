import 'dart:math';

import 'package:endless_runner/components/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/game.dart';

class ObstacleServices implements ObstacleManager {
  final String _className = 'ObstacleServices';
  final List<Obstacle> _obstacles = [];
  final Random _random = Random();
  @override
  void spawnObstacle(EndlessRunnerGame game) {
    LogUtil.debug('Start inside $_className.spawnObstacle ...');

    Obstacle obstacle = Obstacle(position: Vector2(game.size.x, _random.nextDouble() * (game.size.y - 50)));
    _obstacles.add(obstacle);
    game.add(obstacle); // Add obstacle to the game world

  }

}