import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_animation_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class GridBackgroundAnimationServices implements GridBackgroundAnimationManager {
  @override
  SpriteAnimation loopingBackgroundAnimation(EndlessRunnerGame gameRef, Vector2 spriteSize) {
    try {
      return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('backgrounds/grid_bg_sheet.png'), 
        SpriteAnimationData.sequenced(
          amount: 1, 
          stepTime: 0.1, 
          textureSize: spriteSize),
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      throw Exception('Error loading grid background idle animation');
    }
  }

}