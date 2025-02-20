import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_land_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/src/sprite_animation.dart';
import 'package:vector_math/vector_math_64.dart';

class TreeSurfaceLandAnimationService implements TreeSurfaceLandAnimationManager {
  @override
  SpriteAnimation breakableAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    // TODO: implement breakableAnimation
    throw UnimplementedError();
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Tree is idle');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('surfacetolands/trees/idle_tree.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }

}