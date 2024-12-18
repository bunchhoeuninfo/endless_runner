import 'dart:math';

import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/game.dart';

class CoinServices implements CoinManager {

  final String _className = 'CoinServices';
  final List<Coin> _coins = []; 
  final Random _random = Random();
  int _coinsCollected = 0;

  @override
  void checkCoinCollisions(Player player, EndlessRunnerGame game) {
    LogUtil.debug('Start inside $_className.checkCoinCollisions ...');
    for (var coin in _coins) {
      if (player.toRect().overlaps(coin.toRect())) {
        _coinsCollected ++;
        game.remove(coin); // Remove the coin once collected
        game.showCoinCount(_coinsCollected); // Update coin count display
      }
    }
  }

  @override
  void spawnCoins(EndlessRunnerGame game) {
    LogUtil.debug('Start inside $_className.spawnCoins ...');
    
    Coin coin = Coin(Vector2(game.size.x, _random.nextDouble() * (game.size.y - 50)));
    //_coins.add(coin);
    game.add(coin); // Add coin to the game world
    
  }

}