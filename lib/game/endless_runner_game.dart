
import 'dart:math';


import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/components/powerups/speed_boost_manager.dart';
import 'package:endless_runner/components/powerups/speed_boost_services.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/ui/texts/coin_counter.dart';
import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/components/ui/texts/coin_score.dart';
import 'package:endless_runner/components/ui/game_overs/game_over_screen.dart';
import 'package:endless_runner/components/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/components/backgrounds/scrolling_background.dart';
import 'package:endless_runner/components/coins/coin_services.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/obstacles/obstacle_services.dart';
import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/core/game_state_manager.dart';
import 'package:endless_runner/game/assets/image_asset_manager.dart';
import 'package:endless_runner/game/assets/image_asset_services.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector   {
  final String className = 'EndlessRunnerGame';
  late Player player;
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

  // check if game first run or restart
  bool isFirstRun = true;

  @override
  Future<void> onLoad() async {    
    try {
      LogUtil.debug('Start inside EndlessRunnerGame.onLoad...');   
           
      await super.onLoad();      
      await Future.delayed(const Duration(seconds: 1));         
      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));      
       // pre-load image assets to optimize the performance
      await _imageAssetManager.preLoadImgAssets(images);   
      setupBackground();      
         
      _addComponents();      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void _addComponents() {
    try {
      // Add the player      
      player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
      add(player);
      LogUtil.debug('Player added to the game');    

      //Overlay button
      overlays.add('start');      
      overlays.add('setting');

      // Add collision detection
      add(ScreenHitbox());
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void setupBackground() {
    try {
      // Add two full-screen backgrounds for seamless scrolling
      add(ScrollingBackground(position: Vector2(0, -50), baseSpeed: 100));
      add(ScrollingBackground(position: Vector2(size.x, -50), baseSpeed: 100));
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void startGame() {
    
    gameStateManager.setState(GameState.playing);
    LogUtil.debug('Game Started!');
  }

  void pauseGame() {
    gameStateManager.setState(GameState.paused);
    pauseEngine();
    LogUtil.debug('Game Paused!');
  }

  void resumeGame() {
    gameStateManager.setState(GameState.playing);
    resumeEngine();
    LogUtil.debug('Game Resumed!');
  }


  void addToCoinCount(int count) {
    coinCollected += count;
    //LogUtil.debug('Total Coins Collected: $coinCollected');
  }

  void addToCoinScore(int coinPoint) {  
    coinScore += coinPoint;
    //LogUtil.debug('Total Coin Scored: $coinScore');
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    LogUtil.debug('Start inside onTapDown, game screen isVisible=${GameOverScreen().isVisible}');
    if (GameOverScreen().isVisible) return;
    
    if (gameStateManager.isPlaying()) player.jump();
    LogUtil.debug('Screen tapped - Player jumps');    
  }  

  @override
  void update(double dt) {
    super.update(dt);

    //LogUtil.debug('In update, received _gameStateManager: $gameStateManager');    
    
    if (gameStateManager.isPlaying()) {
      LogUtil.debug('Game method gameStateManager.isPlaying() -> {$gameStateManager.isPlaying()}');  
      obstacleTimer += dt;
      if (obstacleTimer >= obstacleSpawnInterval) {
        obstacleTimer = 0;
        _obstacleManager.spawnObstacle(this);
        //LogUtil.debug('Spawned obstacle');
      }

      //spawn coin at intervals
      coinTimer += dt;
      if (coinTimer >= coinSpawnInterval) {
        coinTimer = 0;
        _coinManager.spawnCoins(this);
        //LogUtil.debug('Spawned coin');
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
      pauseEngine();
    } else if (gameStateManager.isMenu()) {
      pauseGame();
      LogUtil.debug('Game method gameStateManager.isMenu() -> {$gameStateManager.isMenu()}');
    }
    
  }  

  void gameOver() {
    LogUtil.debug('Game Over.');
    gameStateManager.setState(GameState.gameOver);
    overlays.add('restart');
    pauseEngine();
  }

  void restartGame() {
    LogUtil.debug('Start method restartGame...');
    
    resumeEngine();  //Resume the game loop
    gameStateManager.setState(GameState.playing);          
    isFirstRun = false;        
    overlays.remove('restart');    
    coinScore = 0;
    coinCollected = 0;
    
    // Reset background
    setupBackground();
    // Remove all objects from game screen    
    children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
    children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
    children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());
    

    obstacleTimer = 0;
    coinTimer = 0;
    speedBoostTimer = 0;
    //Score board
    //add(CoinScore());
    //add(CoinCounter());

  }

}