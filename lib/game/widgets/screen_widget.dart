import 'package:endless_runner/components/ui/buttons/restart_button_overlay.dart';
import 'package:endless_runner/components/ui/buttons/start_button_overlay.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: EndlessRunnerGame(),
            overlayBuilderMap: {
              'start': (context, game) => StartButtonOverlay(game: game as EndlessRunnerGame),
              'restart': (context, game) => RestartButtonOverlay(game: game as EndlessRunnerGame),
            },
            // Show the play overlay initially
            initialActiveOverlays: const ['start'],
          ),
        ],
      ),
    );
  }

}