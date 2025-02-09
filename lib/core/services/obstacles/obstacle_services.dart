import 'dart:math';

import 'package:endless_runner/components/obstacles/car_obstacle.dart';
import 'package:endless_runner/core/managers/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ObstacleServices implements ObstacleManager {

  final List<Obstacle> _obstacles = [];
  final List<CarObstacle> _carObstacles = [];
  final Random _random = Random();
  
  late double _minX;
  late double _maxX;

  void setMovementBounds(EndlessRunnerGame gameRef) {
    _minX = gameRef.size.x * 0.05;
    _maxX = gameRef.size.x * 0.89;
  }

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
  List<CarObstacle> get getCarObstacles => _carObstacles;
  
  @override
  void spawnCarObstacle(EndlessRunnerGame game) {
    setMovementBounds(game);

    // Define the top spawn position
    double spawnY = 0;  // Start at the top of the screen  
    // Ensure X is within the specified range
    double spawnX = _minX + _random.nextDouble() * (_maxX - _minX);

    Rect newCarRect = Rect.fromLTRB(spawnX, spawnY, 60, 100);
  
    if (!game.isOverlapping(newCarRect)) {
      // Create car obstacle at the top
      CarObstacle carObstacle = CarObstacle(position: Vector2(spawnX, spawnY));
      _carObstacles.add(carObstacle);
      game.add(carObstacle);    // Add car obstacle to the game world
      game.addObject(newCarRect);   //Store car obstacle position
    }
  }
}