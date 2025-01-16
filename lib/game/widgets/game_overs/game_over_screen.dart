
import 'package:endless_runner/game/widgets/game_overs/tap_blocker.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends PositionComponent 
  with HasGameRef<EndlessRunnerGame>, TapCallbacks {
  
  bool isVisible = false; // Track visibility manually

  late TextComponent gameOverText;
  late TextComponent restartHintText;
  late TapBlocker _tapBlocker;
  final GameServiceManager _gameServiceManager = GameServiceService();

  GameOverScreen(): super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    LogUtil.debug('Start inside onLoad ...');

    try {

      _tapBlocker = TapBlocker(size: gameRef.size);

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

     /// add(_tapBlocker);     // Blocker will intercept all taps  
      add(restartHintText);
      add(gameOverText);

      isVisible = false;
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }

  void show() {
    LogUtil.debug('Start inside show ....');
    
    if (!isMounted) gameRef.add(this);    // Add to the game tree if not already added
    
    position = gameRef.size / 2; // Center the component
    priority = 100; // Ensure it appears above other components
    isVisible = true;
    gameRef.pauseEngine(); // Pause the game
  }

  void hide() {
    LogUtil.debug('Start inside hide.');
    //priority = -1;
    isVisible = false;
    position = Vector2.all(-1000); // Move off-screen if required
  }

  @override
  void onTapDown(TapDownEvent event) {
    LogUtil.debug('Start inside onTapDown, isVisible = $isVisible');
    if (isVisible) {  
      LogUtil.debug('Restart text tapped.');
      hide();
      _gameServiceManager.restartGame(gameRef);
      //gameRef.restartGame();
      //gameRef.resumeEngine();
      event.handled = true; // Mark the event as handled      
    }    
  }
}