import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/setting_screen.dart';
import 'package:flutter/material.dart';

class SettingButtonOverlay extends StatelessWidget {

  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();
  SettingButtonOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return _buildTopRight(context);
  }

  Positioned _buildTopRight(BuildContext context) {
    LogUtil.debug('Start building setting button overlay at the top right corner.');
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {          
          _gameServiceManager.pauseGame(game);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingScreen(gameRef: game,)),
          );
        },
        child: const Icon(Icons.settings, size: 30, color: Colors.white,),
      ),
    );
  }

}