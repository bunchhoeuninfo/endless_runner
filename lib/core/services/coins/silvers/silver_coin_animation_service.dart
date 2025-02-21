import 'package:endless_runner/core/managers/coins/silvers/silver_coin_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class SilverCoinAnimationService implements SilverCoinAnimationManager {
  @override
  SpriteAnimation hitGroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/silvers/silver_coin_hit_ground.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading silver coin idle animation');
    }
  }

  @override
  SpriteAnimation idleAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/silvers/silver_coin_idle.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading silver coin idle animation');
    }
  }

  @override
  SpriteAnimation spawningAnimation(EndlessRunnerGame gameRef, Vector2 silverCoinsize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/silvers/silver_coin_sheet.png'), 
        SpriteAnimationData.sequenced(
          amount: 4, 
          stepTime: 0.4, 
          textureSize: silverCoinsize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading silver coin spawning animation');
    }
  }

}