import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';


class RoadDownwardBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {

  double baseSpeed; //Speed of background movement
  double currentSpeed;

  final GameStateManager _gameStateManager = GameStateService();
  RoadDownwardBackground({required Vector2 position, required this.baseSpeed})
    : currentSpeed = baseSpeed,
    super(position: position);

  @override
  Future<void> onLoad() async {
    LogUtil.debug('Start onLoad method');
    try {
      size = gameRef.size;
      sprite = Sprite(gameRef.images.fromCache('backgrounds/road_bg.jpeg'));
      LogUtil.debug('Road upward background loaded successfully');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_gameStateManager.stateNotifier.value != GameState.playing) return;
    
    position.y += currentSpeed * dt;
    if (position.y >= size.y) {
      position.y -= size.y * 2;
    }

  }

}