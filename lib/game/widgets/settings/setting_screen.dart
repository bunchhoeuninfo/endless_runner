
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/core/services/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/game_option.dart';
import 'package:endless_runner/game/widgets/settings/widgets/profile_section.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key, required this.gameRef});

  final EndlessRunnerGame gameRef;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();

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
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: _futureLoadPlayer(),
    );
  }

  FutureBuilder _futureLoadPlayer() {
    LogUtil.debug('Inside future build method');
    try {
      return FutureBuilder(
        future: _playerAuthManager.loadPlayerData(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          } else if(snapshot.hasData && snapshot.data is PlayerData) {
            final playerData = snapshot.data as PlayerData;
            LogUtil.debug('Player Data-> name: ${playerData.playerName}');
            return _buildScrollableContent(playerData);            
          } else {
            return const Center(child: Text('Invalid data'),);
          }
        }
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return const Center(child: Text('Invalid data'),);
      });
    }
    
  }

  Widget _buildScrollableContent(PlayerData playerData) {
    LogUtil.debug('Start building Setting.');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(playerData: playerData,),
            const SizedBox(height: 40),
            GameOption(playerData: playerData,),
            const SizedBox(height: 40),
            //const SignInButton(isSignedIn: false),            
          ],
        ),
      ),
    );
  }
  
}