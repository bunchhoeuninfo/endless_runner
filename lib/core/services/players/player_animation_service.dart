import 'package:endless_runner/core/managers/players/player_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';



class PlayerAnimationService implements PlayerAnimationManager {
  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is idle');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_idle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation jumpingAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is jumping');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_jumping.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }
  
  @override
  SpriteAnimation walkingAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is walking');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_post_jump.png'),  // sprite sheet image
        SpriteAnimationData.sequenced(
          amount: 3, // Number of frames in the sprite sheet
          stepTime: 0.1,  // Time per frame (adjust for walk speed)
          textureSize: spriteSize // Size of each frame
        ),
      );
  }
  
  @override
  SpriteAnimation upwardAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    LogUtil.debug('Player is moving upward');
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('players/kitties/kitty_upward.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, 
          textureSize: spriteSize),
      );
  }

}