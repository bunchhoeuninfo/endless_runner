
import 'dart:math';

import 'package:endless_runner/components/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/components/powerups/speed_boost_manager.dart';
import 'package:endless_runner/components/powerups/speed_boost_services.dart';
import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/game/widgets/game_overs/game_over_screen.dart';

import 'package:endless_runner/components/coins/coin_services.dart';
import 'package:endless_runner/components/obstacles/obstacle_services.dart';
import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/core/game_state_manager.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';

import 'package:endless_runner/game/assets/image_asset_manager.dart';
import 'package:endless_runner/game/assets/image_asset_services.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector   {    
  final Random random = Random();
  
  //Image assets
  final ImageAssetManager _imageAssetManager = ImageAssetServices();

  // Obstacles
  double obstacleTimer = 0;  
  final double obstacleSpawnInterval = 2.0; // Obstacle Spawn every 2 seconds
  final ObstacleManager _obstacleManager = ObstacleServices();

  // Coins
  int coinCollected = 0;
  int coinScore = 0;
  final double coinSpawnInterval = 2.0; // Coin Spawn every 2 seconds
  final CoinManager _coinManager = CoinServices();
  double coinTimer = 0;

  // Speed boost 
  final SpeedBoostManager _speedBoostManager = SpeedBoostServices();
  double speedBoostTimer = 0;
  final double speedBoostSpawnInterval = 2.0; // speed boost spawn every 2 seconds

  // State management
  final GameStateManager gameStateManager = GameStateManager();
  //Player
  late Player player;
  // Game service
  final GameServiceManager _gameServiceManager = GameServiceService();

  // check if game first run or restart
  bool isFirstRun = true;

  @override
  Future<void> onLoad() async {    
    player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
    try {
      LogUtil.debug('Try to EndlessRunnerGame.onLoad...');   
           
      await super.onLoad();      
      await Future.delayed(const Duration(seconds: 1));         
      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));      
       // pre-load image assets to optimize the performance
      await _imageAssetManager.preLoadImgAssets(images);
      gameStateManager.setState(GameState.menu);
      _gameServiceManager.setupBackground(this);
      _gameServiceManager.addEntities(this);
      add(player);      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);        
    if (GameOverScreen().isVisible) return;
    
    try {
      LogUtil.debug('Try to jump');
      if (gameStateManager.isPlaying()) {      
        LogUtil.debug('Screen tapped - Player jumps');
        player.jump();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }          
  }  

  @override
  void update(double dt) {
    super.update(dt);    
    
    if (gameStateManager.isPlaying()) {
      //LogUtil.debug('Game method gameStateManager.isPlaying() -> {$gameStateManager.isPlaying()}');  
      obstacleTimer += dt;
      if (obstacleTimer >= obstacleSpawnInterval) {
        obstacleTimer = 0;
        _obstacleManager.spawnObstacle(this);        
      }

      //spawn coin at intervals
      coinTimer += dt;
      if (coinTimer >= coinSpawnInterval) {
        coinTimer = 0;
        _coinManager.spawnCoins(this);        
      }

      //spawn speed boost at intervals
      speedBoostTimer += dt;
      if (speedBoostTimer >= speedBoostSpawnInterval) {
        speedBoostTimer = 0;
        _speedBoostManager.spawnSpeedBoostCoin(this);
        LogUtil.debug('Spawned speed boost coin');
      }
    } else if (gameStateManager.isPaused()) {
      LogUtil.debug('Game method gameStateManager.isPaused() -> {$gameStateManager.isPaused()}');
      _gameServiceManager.pauseGame(this);
    } else if (gameStateManager.isMenu()) {
      _gameServiceManager.pauseGame(this);
      LogUtil.debug('Game method gameStateManager.isMenu() -> {$gameStateManager.isMenu()}');
    }
    
  }  
}