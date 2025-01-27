
import 'package:endless_runner/game/widgets/player_controls/left_control_button.dart';
import 'package:endless_runner/game/widgets/scoreboards/live_score_board.dart';
import 'package:endless_runner/game/widgets/game_controls/level_up_overlay.dart';
import 'package:endless_runner/game/widgets/game_controls/resume_pause_button_overlay.dart';
import 'package:endless_runner/game/widgets/game_controls/restart_button_overlay.dart';
import 'package:endless_runner/game/widgets/game_controls/setting_button_overlay.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/game_controls/start_signup_button_overlay.dart';
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
          _buildGameWidget(),
          /*
          GameWidget(
            game: EndlessRunnerGame(),
            overlayBuilderMap: {              
              'start': (context, game) => StartSignupButtonOverlay(game: game as EndlessRunnerGame),
              //'start': (context, game) => StartSignupButtonOverlay(),
              'restart': (context, game) => RestartButtonOverlay(game: game as EndlessRunnerGame),
              'setting': (context, game) => SettingButtonOverlay(game: game as EndlessRunnerGame),
              'playPause': (context, game) => ResumePauseButtonOverlay(gameRef: game as EndlessRunnerGame),
              'liveScoreBoard': (context, game) => LiveScoreBoard(),
              'levelUp': (context, game) => LevelUpOverlay(game: game as EndlessRunnerGame),

            },
            // Show the play overlay initially
            //initialActiveOverlays: const ['start', 'setting'],
            
            initialActiveOverlays: EndlessRunnerGame().isFirstRun
              ? const ['start', 'setting',] 
              : const ['setting'],
          ),*/
        ],
      ),
    );
  }

  GameWidget _buildGameWidget() {
    return GameWidget(
            game: EndlessRunnerGame(),
            overlayBuilderMap: {              
              'start': (context, game) => StartSignupButtonOverlay(game: game as EndlessRunnerGame),
              'leftControlBtn': (context, game) => LeftControlButton(game: game as EndlessRunnerGame),
              'restart': (context, game) => RestartButtonOverlay(game: game as EndlessRunnerGame),
              'setting': (context, game) => SettingButtonOverlay(game: game as EndlessRunnerGame),
              'playPause': (context, game) => ResumePauseButtonOverlay(gameRef: game as EndlessRunnerGame),
              'liveScoreBoard': (context, game) => LiveScoreBoard(),
              'levelUp': (context, game) => LevelUpOverlay(game: game as EndlessRunnerGame),

            },
            // Show the play overlay initially
            //initialActiveOverlays: const ['start', 'setting'],
            
            initialActiveOverlays: EndlessRunnerGame().isFirstRun
              ? const ['start', 'setting',] 
              : const ['setting'],
          );
  }

}