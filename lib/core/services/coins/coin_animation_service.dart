import 'package:endless_runner/core/managers/coins/coin_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';


class CoinAnimationService implements CoinAnimationManager {
  @override
  SpriteAnimation bronzeCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    LogUtil.debug('Bronze coin animation');
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/blue.jpg'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: coinSize)
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading bronze coin animation');
    }
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
  SpriteAnimation silverCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    LogUtil.debug('Silver coin animation');
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/blue.jpg'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: coinSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading silver coin animation');
    }
  }

  @override
  SpriteAnimation spawnCoinAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    // TODO: implement spawnCoinAnimation
    throw UnimplementedError();
  }
  
  @override
  SpriteAnimation coinsCollectedAnimation(EndlessRunnerGame gameRef, Vector2 coinSize) {
    LogUtil.debug('Coins collected animation');
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('coins/blue.jpg'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: coinSize,
        ),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading coins collected animation');
    }
  }

}