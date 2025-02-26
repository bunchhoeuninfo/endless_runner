import 'dart:math';

import 'package:endless_runner/components/powerups/rocket_booster.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/powerups/rocket_booster_animation_manager.dart';
import 'package:endless_runner/core/managers/powerups/rocket_booster_manager.dart';
import 'package:endless_runner/core/managers/powerups/rocket_booster_state_manager.dart';
import 'package:endless_runner/core/services/powerups/rocket_booster_animation_service.dart';
import 'package:endless_runner/core/services/powerups/rocket_booster_state_service.dart';
import 'package:endless_runner/core/state/rocket_booster_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class RocketBoosterServices implements RocketBoosterManager {

  final double _fallSpeed = 200;    // Speed of rocket booster movement

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
  final RocketBoosterAnimationManager _rocketBoosterAnimationManager = RocketBoosterAnimationService();
  final RocketBoosterStateManager _rocketBoosterStateManager = RocketBoosterStateService();

  @override
  void checkRocketBoosterGravity(double dt, RocketBooster rocketBooster) {
    // TODO: implement checkRocketBoosterGravity
  }

  @override
  void setRocketBoosterSpawnBounds(EndlessRunnerGame gameRef, double dt) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _minY = 0;
      _maxX = screenSize.x;
      _maxY = screenSize.y;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void spawnRocketBooster(EndlessRunnerGame gameRef, double dt) {
    // TODO: implement spawnRocketBooster
  }

  @override
  SpriteAnimation applyRocketBoosterAnimationByState(EndlessRunnerGame gameRef, RocketBooster rocketBooster, Vector2 spriteSize) {
    RocketBoosterState state = _rocketBoosterStateManager.stateNotifier.value;
    LogUtil.debug('Rocket booster state -> $state');

    try {
      if (state == RocketBoosterState.idle) {
        return _rocketBoosterAnimationManager.idleAnimation(gameRef, spriteSize);
      } else if (state == RocketBoosterState.spawning) {
        return _rocketBoosterAnimationManager.spawningAnimation(gameRef, spriteSize);
      }

      return _rocketBoosterAnimationManager.idleAnimation(gameRef, spriteSize);
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return _rocketBoosterAnimationManager.idleAnimation(gameRef, spriteSize);
    }
  }

}