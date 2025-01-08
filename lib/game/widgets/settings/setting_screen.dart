import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/game_option.dart';
import 'package:endless_runner/game/widgets/settings/widgets/profile_section.dart';
import 'package:endless_runner/game/widgets/settings/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key, required this.gameRef});

  final EndlessRunnerGame gameRef;
  final GameServiceManager _gameServiceManager = GameServiceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () {       
            // Resume game
            _gameServiceManager.resumeGame(gameRef);
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: _buildScrollableContent(),
    );
  }

  Widget _buildScrollableContent() {
    LogUtil.debug('Start building Setting.');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(),
            SizedBox(height: 40),
            GameOption(),
            SizedBox(height: 40),
            SignInButton(isSignedIn: false),            
          ],
        ),
      ),
    );
  }

  Padding _buildPadding() {
    LogUtil.debug('Start building Setting.');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          SizedBox(height: 40),
          GameOption(),
          SizedBox(height: 40),
          SignInButton(isSignedIn: false,),
          SizedBox(height: 40),
        ],
      )
    );
  }
  
}