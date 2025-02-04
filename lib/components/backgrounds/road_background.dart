import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class RoadBackground extends ParallaxComponent<EndlessRunnerGame> {
  final double speed;

  RoadBackground({required this.speed});

  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData('backgrounds/road_bg.jpg'),
      ],
      baseVelocity: Vector2(0, speed),  // Moves downward
      repeat: ImageRepeat.repeatY,      // ensure smooth tilling
    );
  }

}