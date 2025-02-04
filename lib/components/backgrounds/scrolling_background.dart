import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class ScrollingBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {
  double baseSpeed; // Speed of the background movement
  double currentSpeed;

  final GameStateManager _gameStateManager = GameStateService();
  
  ScrollingBackground({required Vector2 position , required this.baseSpeed})
      : currentSpeed = baseSpeed,
      super(position: position);

  @override
  Future<void> onLoad() async {

    LogUtil.debug('Start onLoad method');

    try {
      LogUtil.debug('Load sprite upward_background.jpg');      
      size = gameRef.size;      
      sprite = Sprite(gameRef.images.fromCache('bg.jpg'));
      LogUtil.debug('Scrolling background loaded successfully');
    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }    
  }

  @override
  void update(double dt) {
    super.update(dt);
    //if (gameRef.gameStateManager.state != GameState.playing) return;
    if (_gameStateManager.stateNotifier.value != GameState.playing) return;

    // Move the background to the left
    //position.x -= currentSpeed * dt;
    position.y += currentSpeed * dt;

    // If the background moves completely off-screen, reset its position
    /*if (position.x <= -size.x) {
      position.x += 2 * size.x; // Reset to the right of the screen
    }*/

    // If the background moves completely off-screen, reset its position above
    if (position.y >= size.y) {
      position.y -= 2 * size.y; // Move back up
    }
  }

  void updateSpeed(double newSpeed) {
    currentSpeed = newSpeed;
    //LogUtil.debug('ScrollingBackground speed updated to $newSpeed');
  }

  void resetSpeed() {
    currentSpeed = baseSpeed;
    //LogUtil.debug('ScrollingBackground speed reset to $baseSpeed');
  }
}