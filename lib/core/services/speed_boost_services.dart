import 'dart:math';

import 'package:endless_runner/components/backgrounds/scrolling_background.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/managers/speed_boost_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class SpeedBoostServices implements SpeedBoostManager {
  final List<SpeedBoost> _speedBoosts = [];
  final Random _random = Random();

  @override
  void spawnSpeedBoostCoin(EndlessRunnerGame game) {
    LogUtil.debug('Start method spawnSpeedBoostCoin in game state ${game.gameStateManager.state}');

    try {
      LogUtil.debug('Try to initialize speed boost coin');
      final groundLevel = game.size.y / 2;
      double spawnHeight = groundLevel * 0.5;
      for (int i = 0; i < 3; i++) {
        double randomY = groundLevel - _random.nextDouble() * spawnHeight;
        randomY = randomY.clamp(0, groundLevel);
        SpeedBoost speedBoost = SpeedBoost(position: Vector2(game.size.x, randomY));
        //_speedBoosts.add(speedBoost);
        game.add(speedBoost);
      }     
      
      LogUtil.debug('Succesfully initialized speed boost coin');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  List<SpeedBoost> get getSpeedBoosts => _speedBoosts;
  
  @override
  void applySpeedBoost(double boostMultiplier, EndlessRunnerGame game) {
    try {
      LogUtil.debug('try to apply speed boost');
      game.children.whereType<ScrollingBackground>().forEach((background) {
        background.updateSpeed(boostMultiplier);
      });

      // Reset the speed after a delay
      Future.delayed(const Duration(seconds: 5), () {
        game.children.whereType<ScrollingBackground>().forEach((background) {
          background.resetSpeed();
        });
      });
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

}