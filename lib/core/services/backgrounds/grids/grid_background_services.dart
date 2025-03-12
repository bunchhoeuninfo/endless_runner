
import 'package:endless_runner/components/backgrounds/grid_background.dart';
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/utils/screen_utils.dart';
import 'package:flame/components.dart';


class GridBackgroundServices implements GridBackgroundManager {

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  @override
  SpriteAnimation applyGridBackgroundAnimationByState(EndlessRunnerGame gameRef, GridBackground gridBackground, Vector2 spriteSize) {
    // TODO: implement applyGridBackgroundAnimationByState
    throw UnimplementedError();
  }

  @override
  void setGridBackgroundBounds(EndlessRunnerGame gameRef) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}