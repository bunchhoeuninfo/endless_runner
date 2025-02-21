import 'package:endless_runner/core/managers/coins/golds/gold_coin_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GoldCoinAnimationService implements GoldCoinAnimationManager {


  @override
  SpriteAnimation coinsCollectedAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    // TODO: implement coinsCollectedAnimation
    throw UnimplementedError();
  }

  @override
  SpriteAnimation goldCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    LogUtil.debug('Gold coin animation');
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/gold.jpg'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: coinSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception ('Error loading gold coin animation');
    }
  }


  @override
  SpriteAnimation spawnCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    // TODO: implement spawnCoinAnimation
    throw UnimplementedError();
  }
  
  @override
  SpriteAnimation idleGoldCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    LogUtil.debug('Gold coin idle animation');
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/gold.jpg'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: coinSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception ('Error loading gold coin idle animation');
    }
  }

}