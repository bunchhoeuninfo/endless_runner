import 'dart:math';

import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_animation_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_animation_service.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_state_service.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';

import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class GoldCoinService implements GoldCoinManager {

  final double _fallSpeed = 200;    // Speed of gold coin movement

  bool isGrounded = false;
  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final Random _random = Random();
  final GoldCoinStateManager _goldCoinStateManager = GoldCoinStateService();
  final GoldCoinAnimationManager _goldCoinAnimationManager = GoldCoinAnimationService();

  @override
  void handleGoldCoinsCollected(EndlessRunnerGame gameRef) {
    // TODO: implement handleGoldCoinsCollected
  }

  @override
  void removeGoldCoins(EndlessRunnerGame gameRef,  GoldCoin goldCoin) {
    // TODO: implement removeGoldCoins
  }

  @override
  void setGoldCoinSpawnBounds(EndlessRunnerGame gameRef) {
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
  void spawnGoldCoinsDownward(EndlessRunnerGame gameRef , double dt) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;  // Start at the top of the screen 
      _maxY = screenSize.y; 

      // Define number of columns and select one at random
      int totalColumns = 3; // Assuming a 3-column layout
      int selectedColumn = _random.nextInt(totalColumns); // Pick a column randomly

      // Calculate the X position of the selected column
      double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
      double columnX = _minX + (selectedColumn * columnSpacing);

      // Decide how many gold coins to spawn in this column (either 3 or 5)
      int goldCoinCount = _random.nextBool() ? 3 : 5;
      LogUtil.debug('Try to spawn gold coin downward, dt: $dt, isGrounded: $isGrounded, _minX: $_minX, _maxX: $_maxX, _minY: $_minY, _maxY: $_maxY ');

      for (int i = 0; i < goldCoinCount; i++ ) {
        double coinY = _minY - (i * 50); // Space out gold coins in the column        
        //GoldCoin goldCoin = GoldCoin(Vector2(columnX, coinY));
        //gameRef.add(goldCoin);        
      }      

      GoldCoin goldCoin = GoldCoin(Vector2(columnX, _minY));
      gameRef.add(goldCoin); 
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  @override
  void spawnGoldCoins(EndlessRunnerGame gameRef) {
    // TODO: implement spawnGoldCoins
  }

  double _getGameSpeed(int level) {
    return 100 + (level * 20); // Adjust the speed increase per level
  }
  
  @override
  void checkGoldCoinGravity(double dt, GoldCoin goldCoin) {
    try {
      goldCoin.position.y += _fallSpeed * dt;
      _goldCoinStateManager.stateNotifier.value = GoldCoinState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();      
      double groundLevel = screenSize.y - goldCoin.size.y;
      if (goldCoin.position.y > groundLevel) {
        _goldCoinStateManager.stateNotifier.value = GoldCoinState.hitGround;
        goldCoin.removeFromParent();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  SpriteAnimation applyGoldCoinAnimationByState(EndlessRunnerGame gameRef,GoldCoin goldCoin, Vector2 coinSize) {
    GoldCoinState state = _goldCoinStateManager.stateNotifier.value;

    LogUtil.debug('Gold coin state -> $state');  
    try {  
      if (state == GoldCoinState.idle) {
        return _goldCoinAnimationManager.idleGoldCoinAnimation(gameRef, coinSize);
      } else if (state == GoldCoinState.spawning) {
        return _goldCoinAnimationManager.goldCoinSpawningAnimation(gameRef, coinSize);
      } else if (state == GoldCoinState.hitGround) {        
        return _goldCoinAnimationManager.hitGroundGoldCoinAnimation(gameRef, coinSize);
      } 
      
      return _goldCoinAnimationManager.idleGoldCoinAnimation(gameRef, coinSize);           
    } catch (e) {
      LogUtil.error('Exception -> $e');      
      return _goldCoinAnimationManager.idleGoldCoinAnimation(gameRef, coinSize);      
    }
    
  }

}