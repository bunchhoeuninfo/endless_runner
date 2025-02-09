
import 'dart:math';

import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/core/services/games/game_state_service.dart';
import 'package:endless_runner/game/widgets/game_overs/game_over_screen.dart';

import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/core/managers/games/game_state_manager.dart';
import 'package:endless_runner/core/managers/games/game_service_manager.dart';
import 'package:endless_runner/core/services/games/game_service_service.dart';

import 'package:endless_runner/core/managers/games/image_asset_manager.dart';
import 'package:endless_runner/core/services/games/image_asset_services.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
  
  List<Rect> _activeObjects = [];    // Store active coins & car obstacles

  @override
  Future<void> onLoad() async {    
    await super.onLoad();  
    //player = Player(position: Vector2(size.x * 0.02, size.y / 2)); // Starting position
    //player = Player(position: Vector2(50, 50)); // Starting position
    try {
      LogUtil.debug('Try to EndlessRunnerGame.onLoad...');   
      await Future.delayed(const Duration(seconds: 1));        
      //player = Player(position: Vector2(size.x * 0.5, size.y * 0.7)); 
      player = Player(position: Vector2(size.x * 0.5, size.y / 2));
      
      
      //camera.followComponent(player);
      
       // pre-load image assets to optimize the performance
      await _imageAssetManager.preLoadImgAssets(images);
      _gameServiceManager.setupBackground(this);  
      _gameServiceManager.addEntities(this);
      addPlayer();     
      //player.position = Vector2(50, 50);
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  bool isOverlapping(Rect newObject) {
    for (Rect obj in _activeObjects) {
      if (obj.overlaps(newObject)) {
        return true;
      }
    }
    return false;
  }

  void addObject(Rect obj) {
    _activeObjects.add(obj);
  }
  

  void addPlayer() {
    //initialize player position on the screen
    //player = Player(position: Vector2(size.x * 0.5, size.y - player.height));
    // Listen for changes in game state
    _gameStateManager.stateNotifier.addListener(() {
      if (_gameStateManager.stateNotifier.value == GameState.playing) {
        if (!children.contains(player)) {
          add(player);
          LogUtil.debug('Player added to the game world.');
        }
      } 
    });

    // If the game is already in playing state, add the player immediately
    if (_gameStateManager.stateNotifier.value == GameState.playing) {
      add(player);
    } 
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);        
    if (GameOverScreen().isVisible) return;
    
    try {
      LogUtil.debug('Try to jump');     
      if (_gameStateManager.stateNotifier.value == GameState.playing) {
        LogUtil.debug('Screen tapped - Player jumps');
        //player.jump();
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