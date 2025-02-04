import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class RoadBackground extends ParallaxComponent<EndlessRunnerGame> {
  final double speed;

  RoadBackground({required this.speed});

  final GameStateManager _gameStateManager = GameStateService();
  late double backgroundOffsetY; // Track the offset for vertical movement


  @override
  Future<void> onLoad() async {
    // Load the parallax background image
    parallax = await game.loadParallax(
      [
        ParallaxImageData('backgrounds/road_bg.jpg'),
        ParallaxImageData('backgrounds/road_bg.jpg'),
      ],
      baseVelocity: Vector2(0, speed),  // Moves downward (simulate player running upward)
      repeat: ImageRepeat.repeatY,       // Tiling effect
    );
  }


  @override
  void update(double dt) {
    super.update(dt);

    // The background should move continuously based on the baseVelocity
    // No need to manually control position, as the baseVelocity does that
    if (parallax != null) {
      parallax!.baseVelocity = Vector2(0, speed);  // Adjust speed dynamically if needed
    }
  }

}