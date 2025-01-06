import 'dart:math';

import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_type.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/game.dart';

class CoinServices implements CoinManager {

  final String _className = 'CoinServices';
  final List<Coin> _coins = []; 
  final Random _random = Random();
  //final ObstacleServices _obstacleServices = ObstacleServices();

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

}