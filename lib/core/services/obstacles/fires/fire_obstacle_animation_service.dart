import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class FireObstacleAnimationService implements FireObstacleAnimationManager {
  @override
  SpriteAnimation hitGroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('obstacles/fires/fire_obstacle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading fire obstacle hit ground animation');
    }
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('obstacles/fires/fire_obstacle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading fire obstacle idl animation');
    }
  }

  @override
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('obstacles/fires/fire_obstacle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading fire obstacle spawning animation');
    }
  }

}