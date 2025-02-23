import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class TreeSurfaceToLandAnimationService implements TreeSurfaceToLandAnimationManager {
  @override
  SpriteAnimation breakableAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    // TODO: implement breakableAnimation
    throw UnimplementedError();
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Tree is idle');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('surfacetolands/trees/tree_spawning.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Spawning tree animation');
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('surfacetolands/trees/tree_spawning.png'), 
      SpriteAnimationData.sequenced(
        amount: 1, 
        stepTime: 0.1, 
        textureSize: spriteSize,
      ),
    );
  }

}