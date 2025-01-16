import 'package:endless_runner/components/backgrounds/scrolling_background.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/game_state.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GameServiceService implements GameServiceManager {

  @override
  void setupBackground(EndlessRunnerGame game) {
    try {
      // Add two full-screen backgrounds for seamless scrolling
      game.add(ScrollingBackground(position: Vector2(0, -50), baseSpeed: 100));
      game.add(ScrollingBackground(position: Vector2(game.size.x, -50), baseSpeed: 100));
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }   
  }
  
  @override
  void gameOver(EndlessRunnerGame game) {
    if (game.gameStateManager.isPlaying()) {
      try {
        LogUtil.debug('Game Over.');
        game.gameStateManager.setState(GameState.gameOver);
        game.overlays.add('restart');
        game.pauseEngine();
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void restartGame(EndlessRunnerGame game) {
    if (game.gameStateManager.isGameOver()) {
      try {
        LogUtil.debug('Try to restartGame...');
      
        game.resumeEngine();  //Resume the game loop
        game.gameStateManager.setState(GameState.playing);          
        game.isFirstRun = false;        
        game.overlays.remove('restart');
        game.overlays.add('liveScoreBoard');
        
        // Reset background
        setupBackground(game);
        
        // Remove all objects from game screen    
        game.children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
        game.children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
        game.children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void startGame(EndlessRunnerGame game) {
    LogUtil.debug('Game state -> isMenu: ${game.gameStateManager.isMenu()}, isGameOver: ${game.gameStateManager.isGameOver()}, isPause: ${game.gameStateManager.isPaused()}');
    if (game.gameStateManager.isMenu() || game.gameStateManager.isGameOver() || game.gameStateManager.isPaused()) {
      try {
        LogUtil.debug('Try to start game.');
        game.overlays.remove('start');
        game.overlays.add('liveScoreBoard');
        game.isFirstRun = false;
        game.resumeEngine();
        game.gameStateManager.setState(GameState.playing);
        //game.overlays.add(_liveScoreOverlay);
        LogUtil.debug('Game Started!');
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }
  }
  
  @override
  void addEntities(EndlessRunnerGame game) {
    try {
      LogUtil.debug('Try to add entities to the game world.');      

      //Overlay button
      game.overlays.add('start');      
      game.overlays.add('setting');

      // Add collision detection
      game.add(ScreenHitbox());
      
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }
  
  @override
  void pauseGame(EndlessRunnerGame game) {    
    try {
      LogUtil.debug('Try to pause game');
      game.gameStateManager.setState(GameState.paused);    
      game.pauseEngine();
      LogUtil.debug('Game Paused!');    
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }
  
  @override
  void resumeGame(EndlessRunnerGame game) {
    if (game.gameStateManager.isPaused()) {
      try {
        LogUtil.debug('Try to resume game');
        game.gameStateManager.setState(GameState.playing);    
        game.resumeEngine();
        LogUtil.debug('Game Resumed!');    
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }    
  }

}