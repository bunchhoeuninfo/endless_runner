
import 'dart:math';


import 'package:endless_runner/components/buttons/start_button.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/coins/coin_counter.dart';
import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/components/coins/coin_score.dart';
import 'package:endless_runner/components/game_overs/game_over_screen.dart';
import 'package:endless_runner/components/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/components/backgrounds/scrolling_background.dart';
import 'package:endless_runner/components/coins/coin_services.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/obstacles/obstacle_services.dart';
import 'package:endless_runner/state/game_state.dart';
import 'package:endless_runner/state/game_state_manager.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector   {
  final String className = 'EndlessRunnerGame';
  late Player player;
  final Random random = Random();
  final double coinSpawnInterval = 2.0; // Coin Spawn every 2 seconds
  final double obstacleSpawnInterval = 2.0; // Obstacle Spawn every 2 seconds
  double elapsedTime = 0;
  double scoreTimer = 0;
  double obstacleTimer = 0;
  double coinTimer = 0;
  int coinCollected = 0;
  int coinScore = 0;

  final CoinManager _coinManager = CoinServices();
  final ObstacleManager _obstacleManager = ObstacleServices();

  // State management
  final GameStateManager gameStateManager = GameStateManager();
  late StartButton _startButton;

  int score = 0; // score counter
  //late TextComponent scoreText;
  late GameOverScreen _gameOverScreen;
  bool _isGameOver = false;
  //GameState gameState = GameState.playing;  // Track the game state

  @override
  Future<void> onLoad() async {    
    try {
      await Future.delayed(Duration.zero);
      //await super.onLoad();
      LogUtil.debug('Start inside EndlessRunnerGame.onLoad...');
      LogUtil.debug('Game Size: $size');      

      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

      // pre-load coins to optimize the performance
      await images.loadAll([
        'coins/gold.jpg',
        'coins/blue.jpg',
        'coins/red.jpg',
      ]);

      // Add two full-screen backgrounds for seamless scrolling
      add(ScrollingBackground(position: Vector2(0, -50), speed: 100));
      add(ScrollingBackground(position: Vector2(size.x, -50), speed: 100));

      // Add the player
      //player = Player(position: Vector2(size.x * 0.01, size.y / 2)); // Starting position
      player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
      add(player);
      LogUtil.debug('Player added to the game');

      // Add start button
      _startButton = StartButton(() {startGame();});
      add(_startButton);

      // Add score display
      add(CoinScore());
      //scoreText = getScoreText();
      //add(scoreText);
      

      // Add coins, spawn , count coin
      //_coinManager.spawnCoins(this);
      add(CoinCounter());

      // Add Game Over screen but keep it hidden initially
      _gameOverScreen = GameOverScreen();
      //_gameOverScreen.hide();
      add(_gameOverScreen);
      //_gameOverScreen.hide();

      // Add collision detection
      add(ScreenHitbox());

    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }    
  }

  void startGame() {
    gameStateManager.setState(GameState.playing);
    _startButton.removeFromParent(); // Remove the start button
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
    LogUtil.debug('Coins collected: $count');
  }

  void addToCoinCount(int count) {
    coinCollected += count;
    LogUtil.debug('Total Coins Collected: $coinCollected');
  }

  void showCoinScore(int score) {
    LogUtil.debug('Coin scored: $score');
  }

  void addToCoinScore(int coinPoint) {  
    coinScore += coinPoint;
    LogUtil.debug('Total Coin Scored: $coinScore');
  }

  @override
  void onTapDown(TapDownInfo info) {
    LogUtil.debug('Start inside onTapDown, _isGameOver=$_isGameOver');
    final gamePosition = info.eventPosition.global;
    if (_isGameOver) {
      _gameOverScreen.handleTap(gamePosition);
    } else {
      player.jump();
    }
    
    LogUtil.debug('Screen tapped - Player jumps');
  }

  @override
  void update(double dt) {
    super.update(dt);

    LogUtil.debug('In update, received _gameStateManager: $gameStateManager');
    
    if (gameStateManager.isPlaying()) {
      LogUtil.debug('Game is playing');
      // Spawn obstacles at intervals
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
    }
    
  }  

  void gameOver() {
    LogUtil.debug('Start EndlessRunnerGame.gameOver, _isGameOver = $_isGameOver');
    _isGameOver = true;
    pauseEngine();
    _gameOverScreen.show();    
  }

  void restartGame() {
    LogUtil.debug('Start method restartGame...');

    // Hide Game Over screen
    _gameOverScreen.hide();
    _isGameOver = false;

    // Reset game state
    gameStateManager.setState(GameState.menu);
    onLoad();
    coinScore = 0;
    coinCollected = 0;
    //scoreText.text = 'Score: $score';

    // Remove all obstacles and restart game
    children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());
    children.whereType<Coin>().forEach((coin) => coin.removeFromParent());    
    player.resetPosition(); // Reset player position
    resumeEngine();  //Resume the game loop
  }

}