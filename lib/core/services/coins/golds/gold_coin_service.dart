import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/constants/screen_utils.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_manager.dart';
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/services/coins/golds/gold_coin_state_service.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GoldCoinService implements GoldCoinManager {

  bool isGrounded = false;
  double _velocityY = 0;
  double _velocityX = 0;

  // Movement bounds horizontal
  late double _minX;
  late double _maxX;

  // Movement bounds vertical
  late double _minY;
  late double _maxY;

  final GoldCoinStateManager _goldCoinStateManager = GoldCoinStateService();

  @override
  void handleGoldCoinsCollected(EndlessRunnerGame gameRef) {
    // TODO: implement handleGoldCoinsCollected
  }

  @override
  void removeGoldCoins(EndlessRunnerGame gameRef,  GoldCoin goldCoin) {
    // TODO: implement removeGoldCoins
  }

  @override
  void setGoldCoinSpawnBounds(EndlessRunnerGame gameRef) {
    try {
      Vector2 screenSize = ScreenUtils.getScreenSize();
      _minX = 0;
      _maxX = screenSize.x;
      _minY = 0;
      _maxY = screenSize.y; 
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void spanwGoldCoinsDownward(EndlessRunnerGame gameRef , GoldCoin goldCoin, double dt) {
    final groundLevel = _maxY - goldCoin.size.y;
    const topLevel = 0.0;
    const int currentLevel = 1;

    if (!isGrounded) {
      _velocityY += _getGameSpeed(currentLevel) * dt; // Accelerate downwards
      goldCoin.position.y += _velocityY * dt; // Move the gold coin downwards
    }

    // Check if the gold coin has reached the ground
    if (goldCoin.position.y >= groundLevel) {
      goldCoin.position.y = groundLevel;
      _velocityY = 0;
      isGrounded = true;
      _goldCoinStateManager.stateNotifier.value = GoldCoinState.hitGround;
    } else {
      isGrounded = false; // The gold coin is still in the air
    }

    // Present the gold coin from going above the top boundary
    if (goldCoin.position.y < topLevel) {
      goldCoin.position.y = topLevel;   // Lock to the top
      _velocityY = 0;
    }

    goldCoin.position.x = goldCoin.position.x.clamp(_minX, _maxX); // Lock the gold coin within the horizontal bounds

  }

  @override
  void spawnGoldCoins(EndlessRunnerGame gameRef) {
    // TODO: implement spawnGoldCoins
  }

  double _getGameSpeed(int level) {
    return 100 + (level * 20); // Adjust the speed increase per level
  }

}