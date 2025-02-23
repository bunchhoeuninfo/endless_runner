import 'dart:math';

import 'package:endless_runner/components/coins/silver_coin.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/coins/silvers/silver_coin_animation_manager.dart';
import 'package:endless_runner/core/managers/coins/silvers/silver_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/silvers/silver_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/silvers/silver_coin_animation_service.dart';
import 'package:endless_runner/core/services/coins/silvers/silver_coin_state_service.dart';
import 'package:endless_runner/core/state/silver_coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class SilverCoinService implements SilverCoinManager {

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

  final SilverCoinStateManager _silverCoinStateManager = SilverCoinStateService();
  final SilverCoinAnimationManager _silverCoinAnimationManager = SilverCoinAnimationService();
  final Random _random = Random();

  @override
  SpriteAnimation applySilverCoinAnimationByState(EndlessRunnerGame gameRef, SilverCoin silverCoin, Vector2 spriteSize) {
    SilverCoinState state = _silverCoinStateManager.stateNotifier.value;
    LogUtil.debug('Silver coin state -> $state ');
    try {
      if (state == SilverCoinState.idle) {
        return _silverCoinAnimationManager.idleAnimation(gameRef, spriteSize);
      } else if (state == SilverCoinState.spawning) {
        return _silverCoinAnimationManager.spawningAnimation(gameRef, spriteSize);
      } 

      return _silverCoinAnimationManager.idleAnimation(gameRef, spriteSize);
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _silverCoinAnimationManager.idleAnimation(gameRef, spriteSize);
    }
  }

  @override
  void checkSilverCoinGravity(double dt, SilverCoin silvercoin) {
    try {
      silvercoin.position.y += _fallSpeed * dt;
      _silverCoinStateManager.stateNotifier.value = SilverCoinState.spawning;
      Vector2 screenSize = ScreenUtils.getScreenSize();
      double groundLevel = screenSize.y - silvercoin.size.y;
      if (silvercoin.position.y > groundLevel) {
        _silverCoinStateManager.stateNotifier.value = SilverCoinState.hitGround;
        silvercoin.removeFromParent();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void setSilverCoinSpawnBounds(EndlessRunnerGame gameRef) {
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
  void spawnSilverCoinDownward(EndlessRunnerGame gameRef, double dt) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;  // Start at the top of the screen 
      _maxY = screenSize.y; 

      // Define number of columns and select one at random
      int totalColumns = 5; // Assuming a 5-column layout
      int selectedColumn = _random.nextInt(totalColumns); // Pick a column randomly

      // Calculate the X position of the selected column
      double columnSpacing = (_maxX - _minX) / (totalColumns - 1);
      double columnX = _minX + (selectedColumn * columnSpacing);

      // Decide how many silver coins to spawn in this column (either 3 or 5)
      int silverCoinCount = _random.nextBool() ? 3 : 5;
      LogUtil.debug('Try to spawn gold coin downward, dt: $dt, isGrounded: $isGrounded, _minX: $_minX, _maxX: $_maxX, _minY: $_minY, _maxY: $_maxY ');

      for (int i = 0; i < silverCoinCount; i++ ) {
        double coinY = _minY - (i * 35); // Space out gold coins in the column     
        SilverCoin silverCoin = SilverCoin(Vector2(columnX, coinY));
        gameRef.add(silverCoin);
      } 

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}