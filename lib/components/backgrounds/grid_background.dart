import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_manager.dart';
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_state_manager.dart';
import 'package:endless_runner/core/services/backgrounds/grids/grid_background_services.dart';
import 'package:endless_runner/core/services/backgrounds/grids/grid_background_state_service.dart';
import 'package:endless_runner/core/state/grid_background_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GridBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  GridBackground(Vector2 position)
    : super(position: position, size: Vector2(800, 600));

  double speed = 0;
  final GridBackgroundStateManager _gridBackgroundStateManager = GridBackgroundStateService();
  final GridBackgroundManager _gridBackgroundManager = GridBackgroundServices();
  final _gridBackgroundSize = Vector2(800, 600);
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    try {
      LogUtil.debug('Try to load grid background sprite');
      _gridBackgroundStateManager.stateNotifier.value = GridBackgroundState.idle;
      _gridBackgroundManager.setGridBackgroundBounds(gameRef);

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
   
}