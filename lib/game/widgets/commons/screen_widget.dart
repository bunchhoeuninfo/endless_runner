import 'package:endless_runner/components/ui/buttons/play_pause_button.dart';
import 'package:endless_runner/components/ui/buttons/restart_button_overlay.dart';
import 'package:endless_runner/components/ui/buttons/setting_button_overlay.dart';
import 'package:endless_runner/components/ui/buttons/start_reset_button_overlay.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('EndlessRunnerGame().isFirstRun -> ${EndlessRunnerGame().isFirstRun}');
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: EndlessRunnerGame(),
            overlayBuilderMap: {              
              'start': (context, game) => StartResetButtonOverlay(game: game as EndlessRunnerGame),
              'restart': (context, game) => RestartButtonOverlay(game: game as EndlessRunnerGame),
              'setting': (context, game) => SettingButtonOverlay(game: game as EndlessRunnerGame),
            },
            // Show the play overlay initially
            //initialActiveOverlays: const ['start', 'setting'],
            
            initialActiveOverlays: EndlessRunnerGame().isFirstRun
              ? const ['start', 'setting']
              : const ['setting'],
          ),
        ],
      ),
    );
  }

}