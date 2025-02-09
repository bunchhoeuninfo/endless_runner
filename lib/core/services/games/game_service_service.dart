
import 'package:endless_runner/components/backgrounds/road_background.dart';
import 'package:endless_runner/components/backgrounds/road_downward_background.dart';
import 'package:endless_runner/components/backgrounds/scrolling_background.dart';
import 'package:endless_runner/components/coins/coin.dart';
import 'package:endless_runner/components/obstacles/car_obstacle.dart';
import 'package:endless_runner/components/obstacles/obstacle.dart';
import 'package:endless_runner/components/powerups/speed_boost.dart';
import 'package:endless_runner/core/managers/coins/coin_manager.dart';
import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/managers/obstacles/obstacle_manager.dart';
import 'package:endless_runner/core/managers/players/speed_boost_manager.dart';

import 'package:endless_runner/core/services/coins/coin_services.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/core/services/obstacles/obstacle_services.dart';
import 'package:endless_runner/core/services/players/speed_boost_services.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/core/managers/games/game_service_manager.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';

class GameServiceService implements GameServiceManager {
  //final GameServiceManager _gameServiceManager = GameServiceService();
  final GameStateManager _gameStateManager = GameStateService();
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

  // Initialize player
  //final PlayerMovementManager _playerMovementManager = PlayerMovementService();

  @override
  void setupBackground(EndlessRunnerGame game) {
    try {
      // Add two full-screen backgrounds for seamless scrolling
      //game.add(ScrollingBackground(position: Vector2(0, -50), baseSpeed: 100));
      //game.add(ScrollingBackground(position: Vector2(game.size.x, -50), baseSpeed: 100));
      game.add(RoadDownwardBackground(position: Vector2(0, -game.size.y), baseSpeed: 100));
      game.add(RoadDownwardBackground(position: Vector2(0, 0), baseSpeed: 100));
      //game.add(RoadBackground(speed:100));
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }   
  }
  
  @override
  void gameOver(EndlessRunnerGame game) {
    //if (game.gameStateManager.isPlaying()) {
    if (_gameStateManager.stateNotifier.value == GameState.playing) {
      try {
        LogUtil.debug('Game Over.');
        _gameStateManager.stateNotifier.value = GameState.gameOver;
        game.overlays.add('restart');
        game.pauseEngine();
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void restartGame(EndlessRunnerGame game) {
    //if (game.gameStateManager.isGameOver()) {
    if (_gameStateManager.stateNotifier.value == GameState.gameOver) {
      try {
        LogUtil.debug('Try to restartGame...');
      
        game.resumeEngine();  //Resume the game loop   
        _gameStateManager.stateNotifier.value = GameState.playing;
        //_playerMovementManager.setMovementBounds(game);
        game.isFirstRun = false;        
        game.overlays.remove('restart');
        game.overlays.add('liveScoreBoard');
        
        // Reset background
        setupBackground(game);

        // Reset player position
        game.player.resetPosition();
        
        // Remove all objects from game screen    
        //game.children.whereType<Obstacle>().forEach((obstacle) => obstacle.removeFromParent());        
        //game.children.whereType<Coin>().forEach((coin) => coin.removeFromParent());
        //game.children.whereType<SpeedBoost>().forEach((speedBoost) => speedBoost.removeFromParent());
        game.children.whereType<CarObstacle>().forEach((carObstacle) => carObstacle.removeFromParent());
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }        
  }
  
  @override
  void startGame(EndlessRunnerGame game) {
    //LogUtil.debug('Game state -> isMenu: ${game.gameStateManager.isMenu()}, isGameOver: ${game.gameStateManager.isGameOver()}, isPause: ${game.gameStateManager.isPaused()}');
    try {
      LogUtil.debug('Try to start game.');
      List<String> overlayTexts = ['start', 'levelUp', 'restart', 'gameOver'];
      game.overlays.removeAll(overlayTexts);
      game.overlays.add('liveScoreBoard');
      game.isFirstRun = false;
      game.resumeEngine();
      //_playerMovementManager.setMovementBounds(game);
      _gameStateManager.stateNotifier.value = GameState.playing;
      LogUtil.debug('Game Started!');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
    
  }
  
  @override
  void addEntities(EndlessRunnerGame game) {    
    try {
      LogUtil.debug('Try to add overlay control to the game world.');  
      List<String> overlayBtns = ['start', 'setting', 'playPause','leftControlBtn','rightControlBtn','boostPlayerSpeed', 'upwardBtn'];
    
      // Overlay ojects
      game.overlays.addAll(overlayBtns);

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
      game.pauseEngine();
      LogUtil.debug('Game Paused!');    
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }
  
  @override
  void resumeGame(EndlessRunnerGame game) {
    if (_gameStateManager.stateNotifier.value == GameState.resumed) {
      try {
        LogUtil.debug('Try to resume game');
        _gameStateManager.stateNotifier.value = GameState.playing;
        game.resumeEngine();
        LogUtil.debug('Game Resumed!');    
      } catch (e) {
        LogUtil.error('Exception -> $e');
      }
    }
  }
  
  @override
  void levelUp(EndlessRunnerGame game) {
    try {
      LogUtil.debug('Level Up!');
      _gameStateManager.stateNotifier.value = GameState.menu;
      game.overlays.add('levelUp');
      game.pauseEngine();
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void onGameStateChanged(double dt, GameState state, EndlessRunnerGame game) {
   // LogUtil.debug('Game method gameStateManager.stateNotifier.value -> ${_gameStateManager.stateNotifier.value}');
    if (state == GameState.playing) {
      _spawnCarObstacle(dt, game);
      _spawnDownwardCoin(dt, game);
      //startGame(game);       
      //_spawnObstacle(dt, game);
      //spawn coin at intervals
      //_spawnCoin(dt, game);
      //spawn speed boost at intervals
      //_speedBoost(dt, game);
    } 
    else if (_gameStateManager.stateNotifier.value == GameState.paused) {
      LogUtil.debug('Game method gameStateManager.isPaused() -> ${_gameStateManager.stateNotifier.value}');
      pauseGame(game);
    } else if (_gameStateManager.stateNotifier.value == GameState.resumed) {
      LogUtil.debug('Game method gameStateManager.isResumed() -> ${_gameStateManager.stateNotifier.value}');
      resumeGame(game);
    } 
    else if (_gameStateManager.stateNotifier.value == GameState.menu) {
      game.pauseEngine();
      LogUtil.debug('Game method gameStateManager.isMenu() -> ${_gameStateManager.stateNotifier.value}');
    } else if (state == GameState.setting) {
      LogUtil.debug('Try to pause the game engine when player goto setting section');
      pauseGame(game);
    }
  }

  void _spawnCarObstacle(double dt, EndlessRunnerGame game) {
    obstacleTimer += dt;
    if (obstacleTimer >= obstacleSpawnInterval) {
      obstacleTimer = 0;
      _obstacleManager.spawnCarObstacle(game);
    }
  }

  void _spawnObstacle(double dt, EndlessRunnerGame game) {
    obstacleTimer += dt;
    if (obstacleTimer >= obstacleSpawnInterval) {
      obstacleTimer = 0;
      _obstacleManager.spawnObstacle(game);        
    }
  }

  void _spawnDownwardCoin(double dt, EndlessRunnerGame gameRef) {
    coinTimer += dt;
    if (coinTimer >= coinSpawnInterval) {
      coinTimer = 0;
      _coinManager.spawnDownwardCoin(gameRef);
    }
  }

  void _spawnCoin(double dt, EndlessRunnerGame game) {
    coinTimer += dt;
    if (coinTimer >= coinSpawnInterval) {
      coinTimer = 0;
      _coinManager.spawnCoins(game);        
    }
  }

  void _speedBoost(double dt, EndlessRunnerGame game) {
    speedBoostTimer += dt;
    if (speedBoostTimer >= speedBoostSpawnInterval) {
      speedBoostTimer = 0;
      _speedBoostManager.spawnSpeedBoostCoin(game);        
    }
  }
  


}