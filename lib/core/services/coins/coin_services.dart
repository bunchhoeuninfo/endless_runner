import 'dart:math';

import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/coins/coin_manager.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CoinServices implements CoinManager {

  final String _className = 'CoinServices';
  final List<Coin> _coins = []; 
  final Random _random = Random();
  //final ObstacleServices _obstacleServices = ObstacleServices();

  bool isGrounded = false;
  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  void setMovementBounds(EndlessRunnerGame gameRef) {
    _minX = gameRef.size.x * 0.05;
    _maxX = gameRef.size.x * 0.89;
  }

  @override
  void checkCoinCollisions(Player player, EndlessRunnerGame game) {
    LogUtil.debug('Start inside checkCoinCollisions ...');
    int coinsCollected = 0;
    for (var coin in _coins) {
      if (player.toRect().overlaps(coin.toRect())) {
        coinsCollected ++;

        // Increase score based on coin type
        int pointToAdd = 0;
        switch (coin.type) {
          case CoinType.gold:
            pointToAdd = 10;
            break;
          case CoinType.red:
            pointToAdd = 8;
            break;
          case CoinType.blue:
            pointToAdd = 5;
            break;          
        }
        //
        //game.showCoinCount(coinsCollected); // Update coin count display
        //game.showCoinScore(pointToAdd);   
        game.remove(coin); // Remove the coin once collected        
      }
    }
  }

  @override
  void spawnCoins(EndlessRunnerGame game) {
    LogUtil.debug('Start inside $_className.spawnCoins ...');
    
    // Define the bottom range
    final groundLevel = game.size.y / 2;    
    // Define the spawn range above the ground level
    double spawnHeight = groundLevel * 0.5;
    

    for (int i = 0; i < 10; i++) {
      final randomCoinType = CoinType.values[_random.nextInt(CoinType.values.length)];      
      double randomY = groundLevel - _random.nextDouble() * spawnHeight;
      // Ensure Y is valid and within visible bounds
      randomY = randomY.clamp(0, groundLevel);
      // Random X position for the coin
      double randomX = game.size.x + (i * 50);
      
      //Coin coin = Coin(Vector2(game.size.x, _random.nextDouble() * (game.size.y - 50)));
      //Coin coin = Coin(Vector2(game.size.x, randomY), randomCoinType);
      Coin coin = Coin(Vector2(randomX, randomY), randomCoinType);
      game.add(coin); // Add coin to the game world
      //LogUtil.debug('Spawned a ${randomCoinType.name} coin at (${coin.position.x}, ${coin.position.y}) relative to ground level: $groundLevel');
    }
    
  }
  
  @override
  void spawnDownwardCoin(EndlessRunnerGame game) {
    //setMovementBounds(game);

    double spawnY = 0; // Start at the top of the screen

    // Define number of columns and select one at random
    int totalColumns = 5; // Assuming a 5-column layout
    int selectedColumn = _random.nextInt(totalColumns); // Pick a column randomly

    // Calculate the X position of the selected column
    double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
    double columnX = _minX + (selectedColumn * columnSpacing);

    // Decide how many coins to spawn in this column (either 3 or 5)
    int coinCount = _random.nextBool() ? 3 : 5;

    for (int i = 0; i < coinCount; i++) {
      final randomCoinType = CoinType.values[_random.nextInt(CoinType.values.length)];
      double coinY = spawnY - (i * 50); // Space out coins in the column

      Rect newCoinRect = Rect.fromLTRB(columnX, coinY, 50, 50);

      if (!game.isOverlapping(newCoinRect)) {
        Coin coin = Coin(Vector2(columnX, coinY), randomCoinType);
        game.add(coin);
        game.addObject(newCoinRect);    // Store coin position
        LogUtil.debug('Spawned a ${randomCoinType.name} coin at (${coin.position.x}, ${coin.position.y})');
      
      }  
    }
  }

  Vector2 _getScreenSize() {
    final Size screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    
    return Vector2(screenSize.width, screenSize.height);
  }
  
  @override
  void removeCoins(EndlessRunnerGame gameRef) {
    // TODO: implement removeCoins
  }
  
  @override
  void setCoinSpawnBounds(EndlessRunnerGame game) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;
      _maxY = screenSize.y; 
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  void spawnCoinDownward(EndlessRunnerGame gameRef, Coin coin, double dt) {
    double spawnY = 0; // Start at the top of the screen

    // Define number of columns and select one at random
    int totalColumns = 5; // Assuming a 5-column layout
    int selectedColumn = _random.nextInt(totalColumns); // Pick a column randomly

    // Calculate the X position of the selected column
    double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
    double columnX = _minX + (selectedColumn * columnSpacing);

    // Decide how many coins to spawn in this column (either 3 or 5)
    int coinCount = _random.nextBool() ? 3 : 5;

    for (int i = 0; i < coinCount; i++) {
      final randomCoinType = CoinType.values[_random.nextInt(CoinType.values.length)];
      double coinY = spawnY - (i * 50); // Space out coins in the column

      Rect newCoinRect = Rect.fromLTRB(columnX, coinY, 50, 50);

      if (!gameRef.isOverlapping(newCoinRect)) {
        Coin coin = Coin(Vector2(columnX, coinY), randomCoinType);
        gameRef.add(coin);
        gameRef.addObject(newCoinRect);    // Store coin position
        LogUtil.debug('Spawned a ${randomCoinType.name} coin at (${coin.position.x}, ${coin.position.y})');      
      }  
    }
  }
  
  @override
  void handleCoinsCollected(EndlessRunnerGame gameRef, Coin coin) {
    LogUtil.debug('Start inside handleCoinsCollected ...');
    try {
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
}