
import 'dart:math';

import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/game/widgets/game_overs/game_over_screen.dart';

import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/managers/game_service_manager.dart';
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
  // State management
  final GameStateManager _gameStateManager = GameStateService();
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
      if (_gameStateManager.stateNotifier.value == GameState.playing) {
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
    //LogUtil.debug('Game method update -> $dt');
    final state = _gameStateManager.stateNotifier.value;
    _gameServiceManager.onGameStateChanged(dt, state, this);
  }  
}