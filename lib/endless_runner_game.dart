
import 'dart:math';

import 'package:endless_runner/components/game_over_screen.dart';
import 'package:endless_runner/components/player.dart';
import 'package:endless_runner/components/scrolling_background.dart';
import 'package:endless_runner/obstacles/obstacle.dart';
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
  final double obstacleSpawnInterval = 2.0; // Spawn every 2 seconds
  double elapsedTime = 0;
  double scoreTimer = 0;
  double obstacleTimer = 0;

  int score = 0; // score counter
  late TextComponent scoreText;
  GameState gameState = GameState.playing;  // Track the game state


  @override
  Future<void> onLoad() async {    
    LogUtil.debug('Start inside EndlessRunnerGame.onLoad...');

    try {
      await super.onLoad();
      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

      // Add two full-screen backgrounds for seamless scrolling
      add(ScrollingBackground(startX: 0));
      add(ScrollingBackground(startX: size.x));

      // Add the player
      player = Player();
      add(player);

      // Add score display
      scoreText = getScoreText();
      add(scoreText);

      // Add collision detection
      add(ScreenHitbox());

    } catch (e, stackTrace) {
      LogUtil.error('Exception -> $e, $stackTrace');
    }    
  }

  TextComponent getScoreText() {
    return TextComponent(
        text: 'Score: 0',
        position: Vector2(10, 10),  // Top-Left corner
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.amberAccent, fontSize: 24),
        ),
      );
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
      add(Obstacle(
        position: Vector2(size.x, random.nextDouble() * (size.y - 50)), // Random Y
      ));
    } 
  }

  void increaseScore() {
    LogUtil.debug('Start inside $className.increaseScore...');
    score += 1; // Increase the score
    scoreText.text = 'Score: $score'; // Update the displayed score
    LogUtil.debug('Score updated: $score');
  }

  void gameOver() {
    LogUtil.debug('Start $className.gameOver ...');
    
    gameState = GameState.gameOver; // Switch to Game Over state
    pauseEngine();
    add(GameOverScreen(onRestart: restartGame));
    LogUtil.debug('Game Over! Final Score: $score');
  }

  void restartGame() {
    // Reset game state
    gameState = GameState.playing;
    score = 0;
    scoreText.text = 'Score: $score';

    // Remove all obstacles and restart game
    children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());
    player.resetPosition(); // Reset player position
    resumeEngine();  //Resume the game loop
  }

}