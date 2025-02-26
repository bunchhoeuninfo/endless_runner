
import 'package:endless_runner/core/managers/powerups/rocket_booster_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class RocketBoosterAnimationService implements RocketBoosterAnimationManager {
  @override
  SpriteAnimation hitGroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('rocket_booster.png'), 
        SpriteAnimationData.sequenced(
          amount: 3, 
          stepTime: 0.3, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading rocket booster hitGround animation');
    }
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('rocket_booster.png'), 
        SpriteAnimationData.sequenced(
          amount: 3, 
          stepTime: 0.3, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading rocket booster idle animation');
    }
  }

  @override
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('rocket_booster.png'), 
        SpriteAnimationData.sequenced(
          amount: 3, 
          stepTime: 0.3, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading rocket booster spawning animation');
    }
  }

}