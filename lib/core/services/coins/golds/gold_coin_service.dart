import 'dart:math';

import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_state_service.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

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

      LogUtil.debug('Try to spawn gold coin downward, dt: $dt, isGrounded: $isGrounded, _minX: $_minX, _maxX: $_maxX, _minY: $_minY, _maxY: $_maxY ');
      
      //final groundLevel = _maxY - goldCoin.size.y;
      double spawnY = 0;  // Start at the top of the screen 
      const int currentLevel = 1;
      double spawnX = _minX + _random.nextDouble() * (_maxX - _minX);
      Rect newRoadConeRect = Rect.fromLTRB(spawnX, spawnY, 60, 100);
      GoldCoin goldCoin = GoldCoin(Vector2(100, 0));
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

}