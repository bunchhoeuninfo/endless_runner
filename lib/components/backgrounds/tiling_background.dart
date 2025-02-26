import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TilingBackground extends SpriteComponent with HasGameRef<EndlessRunnerGame> {

  TilingBackground() : super();

  @override
  Future<void> onLoad() async {    
    super.onLoad();

    try {
      LogUtil.debug('Load sprite upward_background.jpg');
      sprite = await gameRef.loadSprite('bg.jpg');
      size = Vector2(gameRef.size.x, gameRef.size.y);
      LogUtil.debug('Load sprite upward_background.jpg is completed');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    LogUtil.debug('Start rendering canvas');
    final paint = sprite!.paint;
    final image = sprite!.image;
    final size = sprite!.srcSize;

    for (double y = 0; y < gameRef.size.y; y += size.y) {
      for (double x = 0; x < gameRef.size.x; x += size.x) {
        
      }
    } 
  }

}