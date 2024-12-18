
import 'dart:math';


import 'package:endless_runner/components/coins/coin_counter.dart';
import 'package:endless_runner/components/coins/coin_manager.dart';
import 'package:endless_runner/components/game_overs/game_over_screen.dart';
import 'package:endless_runner/components/obstacles/obstacle_manager.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/components/scrolling_background.dart';
import 'package:endless_runner/components/coins/coin_services.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/obstacles/obstacle_services.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum GameState { playing, gameOver}

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
  double coinCount = 0;

  final CoinManager _coinManager = CoinServices();
  final ObstacleManager _obstacleManager = ObstacleServices();

  int score = 0; // score counter
  late TextComponent scoreText;
  late GameOverScreen _gameOverScreen;
  bool _isGameOver = false;
  GameState gameState = GameState.playing;  // Track the game state


  @override
  Future<void> onLoad() async {    
    try {
      await Future.delayed(Duration.zero);
      //await super.onLoad();
      LogUtil.debug('Start inside EndlessRunnerGame.onLoad...');
      LogUtil.debug('Game Size: $size');

      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

      // Add two full-screen backgrounds for seamless scrolling
      add(ScrollingBackground(startX: 0));
      add(ScrollingBackground(startX: size.x));

      // Add the player
      player = Player(position: Vector2(size.x * 0.1, size.y / 2)); // Starting position
      add(player);
      LogUtil.debug('Player added to the game');

      // Add score display
      scoreText = getScoreText();
      add(scoreText);

      // Add coins, spawn , count coin
      _coinManager.spawnCoins(this);
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


  TextComponent getScoreText() {
    return TextComponent(
        text: 'Score: $score',
        position: Vector2(10, 10),  // Top-Left corner
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.amberAccent, fontSize: 24),
        ),
      );
  }

  void showCoinCount(int count) {
    LogUtil.debug('Coins collected: $count');
  }

  void addToCoinCount(int count) {
    coinCount += count;
    LogUtil.debug('Total Coins Collected: $coinCount');
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (_isGameOver) {
      //_gameOverScreen.onTapDown();
      _gameOverScreen.handleTap(info.eventPosition.global);
    } else {
      player.jump();
    }
    
    LogUtil.debug('Screen tapped - Player jumps');
  }

  @override
  void update(double dt) {
    super.update(dt);

    LogUtil.debug('Start inside $className.update...');

    if (gameState == GameState.playing) {
      // Update game logic only if playing
      scoreText.text = 'Score: $score';
    }
    
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

  void increaseScore() {
    LogUtil.debug('Start inside $className.increaseScore...');
    score += 1; // Increase the score
    scoreText.text = 'Score: $score'; // Update the displayed score
    LogUtil.debug('Score updated: $score');
  }

  void gameOver() {
    LogUtil.debug('Start EndlessRunnerGame.gameOver ...');
    _isGameOver = true;
    _gameOverScreen.show();
    pauseEngine();
  }

  void restartGame() {
    LogUtil.debug('Start method restartGame...');

    // Hide Game Over screen
    _gameOverScreen.hide();
    _isGameOver = false;

    // Reset game state
    gameState = GameState.playing;
    score = 0;
    coinCount = 0;
    scoreText.text = 'Score: $score';

    // Remove all obstacles and restart game
    children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());
    player.resetPosition(); // Reset player position
    resumeEngine();  //Resume the game loop
  }

}