import 'dart:math';

import 'package:endless_runner/core/managers/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/game.dart';

class ObstacleServices implements ObstacleManager {

  final List<Obstacle> _obstacles = [];
  final Random _random = Random();

  @override
  void spawnObstacle(EndlessRunnerGame game) {
    //LogUtil.debug('Start inside $_className.spawnObstacle ...');

    // Define the bottom range
    final groundLevel = game.size.y / 2;

    // Define the spawn range above the ground level
    double spawnHeight = groundLevel * 0.4;
    double randomY = groundLevel - _random.nextDouble() * spawnHeight;
    // Ensure Y is valid and within visible bounds
    randomY = randomY.clamp(0, groundLevel);

    //Obstacle obstacle = Obstacle(position: Vector2(game.size.x, _random.nextDouble() * (game.size.y - 50)));
    Obstacle obstacle = Obstacle(position: Vector2(game.size.x, randomY));
    _obstacles.add(obstacle);
    game.add(obstacle); // Add obstacle to the game world

    //LogUtil.debug('Obstacle spawned at (${obstacle.position.x}, ${obstacle.position.y}) relative to ground level: $groundLevel');

  }

  List<Obstacle> get getObstacles => _obstacles;



}