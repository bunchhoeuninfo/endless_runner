
import 'package:endless_runner/endless_runner_game.dart';
import 'package:endless_runner/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends PositionComponent 
  with HasGameRef<EndlessRunnerGame>, TapCallbacks {
  
  final String _className = 'GameOverScreen';
  bool isVisible = false; // Track visibility manually

  late TextComponent gameOverText;
  late TextComponent restartHintText;


  GameOverScreen(): super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Start inside $_className.onLoad ...');

    try {
      // Game Over Text
      gameOverText = TextComponent(
        text: 'Game Over',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      )
        ..anchor = Anchor.center
        ..position = Vector2(0, -100); // Position above the center
      add(gameOverText);

      // Restart Hint Text
      restartHintText = TextComponent(
        text: 'Tap to Restart',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      )
        ..anchor = Anchor.center
        ..position = Vector2(0, -50); // Position below the center
      add(restartHintText);

      // Start as hidden
      //priority = -1;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  void show() {
    LogUtil.debug('Start inside $_className.show ....');
    if (!isMounted) {
      gameRef.add(this);    // Add to the game tree if not already added
    }
    position = gameRef.size / 2; // Center the component
    priority = 100; // Ensure it appears above other components
    isVisible = true;
    gameRef.pauseEngine(); // Pause the game
  }

  void hide() {
    LogUtil.debug('Start inside $_className.hide ....');
    //priority = -1;
    isVisible = false;
    gameOverText.position = Vector2(0, -100);
    restartHintText.position = Vector2(0, -50);
   // removeFromParent();
  }

  void handleTap(Vector2 tapPosition) {
    LogUtil.debug('Start inside handleTap, isVisible = $isVisible');
    if (isVisible) {
      // Hide the game over screen
      isVisible = false;

      // Reset the game over screen state if needed
      position = Vector2.all(-1000); // Move off-screen if required
      LogUtil.debug('GameOver screen is reset and hidden.');
      
      gameRef.resumeEngine(); // Resume the game
      gameRef.restartGame(); // Reset the game
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    LogUtil.debug('Start inside $_className.onTapDown, isVisible = $isVisible');
    super.onTapDown(event);
    if (isVisible) {
      gameRef.resumeEngine(); // Resume the game
      gameRef.restartGame(); // Reset the game
    }    
  }

}