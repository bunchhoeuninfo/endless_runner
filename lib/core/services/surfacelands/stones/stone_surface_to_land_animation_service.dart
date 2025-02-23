import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class StoneSurfaceToLandAnimationService implements StoneSurfaceToLandAnimationManager {
  @override
  SpriteAnimation hitGroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('surfacetolands/stones/stone_spawning.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading stone surface hit groun animation');
    }
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('surfacetolands/stones/stone_spawning.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading stone surface idle animation');
    }
  }

  @override
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('surfacetolands/stones/stone_spawning.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading stone surface spawning animation');
    }
  }
}