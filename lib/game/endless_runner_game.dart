
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
      await Future.delayed(Duration.zero);
      //await super.onLoad();
      LogUtil.debug('Start inside EndlessRunnerGame.onLoad...');      

      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

      // pre-load coins to optimize the performance
      await _imageAssetManager.preLoadImgAssets(images);
      setupBackground();      
      _addComponents();
      // Add the player      
      //player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
      // Setup background
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void _addComponents() {
    // Add the player      
    player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
    add(player);
    LogUtil.debug('Player added to the game');    

    //Overlay button
    overlays.add('start');
    overlays.add('setting');

    

    // Add collision detection
    add(ScreenHitbox());
  }

  void setupBackground() {
    // Add two full-screen backgrounds for seamless scrolling
    add(ScrollingBackground(position: Vector2(0, -50), baseSpeed: 100));
    add(ScrollingBackground(position: Vector2(size.x, -50), baseSpeed: 100));
  }

  void startGame() {
    
    gameStateManager.setState(GameState.playing);
    //_startButton.removeFromParent(); // Remove the start button
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

  void showCoinCount(int count) {
    //LogUtil.debug('Coins collected: $count');
  }

  void addToCoinCount(int count) {
    coinCollected += count;
    //LogUtil.debug('Total Coins Collected: $coinCollected');
  }

  void showCoinScore(int score) {
    //LogUtil.debug('Coin scored: $score');
  }

  void addToCoinScore(int coinPoint) {  
    coinScore += coinPoint;
    //LogUtil.debug('Total Coin Scored: $coinScore');
  }

  @override
  void onTapDown(TapDownInfo info) {
    LogUtil.debug('Start inside onTapDown, game screen isVisible=${GameOverScreen().isVisible}');
    if (GameOverScreen().isVisible) return;

    player.jump();
    LogUtil.debug('Screen tapped - Player jumps');
    super.onTapDown(info);
  }  

  @override
  void update(double dt) {
    super.update(dt);

    //LogUtil.debug('In update, received _gameStateManager: $gameStateManager');    
    
    if (gameStateManager.isPlaying()) {
      //LogUtil.debug('Game is playing');
      // Spawn obstacles at intervals
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

    //player.resetPosition(); // Reset player position
    resumeEngine();  //Resume the game loop
    // Add start overlay button
    //overlays.add('start');
    gameStateManager.setState(GameState.playing);    
      
    // if restart then remove start & reset overlay
    isFirstRun = false;
    //overlays.remove('start');

    // Reset game state
    //gameStateManager.setState(GameState.menu);
    overlays.remove('restart');
    //onLoad();
    coinScore = 0;
    coinCollected = 0;
    
    // Remove all objects from game screen
    children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
    children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
    children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());

    obstacleTimer = 0;
    coinTimer = 0;
    speedBoostTimer = 0;
    //Score board
    add(CoinScore());
    add(CoinCounter());

    

  }

}