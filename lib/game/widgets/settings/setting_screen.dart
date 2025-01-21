
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/core/managers/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/menu_settings/menu_section.dart';
import 'package:endless_runner/game/widgets/settings/widgets/profiles/profile_section.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key, required this.gameRef});

  final EndlessRunnerGame gameRef;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();
  final GameStateManager _gameStateManager = GameStateService();


  @override
  Widget build(BuildContext context) {

    LogUtil.debug('Initiate game setting');
    //gameRef.gameStateManager.setState(GameState.menu);
    _gameStateManager.stateNotifier.value = GameState.menu;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () { 
            // Resume game
            LogUtil.debug('Game state -> ${_gameStateManager.stateNotifier.value}');
            _gameStateManager.stateNotifier.value == GameState.paused 
              ? _gameServiceManager.resumeGame(gameRef)
              : //gameRef.gameStateManager.setState(GameState.menu);
                _gameStateManager.stateNotifier.value = GameState.menu;
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
          //final pd = snapshot.data as PlayerData;
          //LogUtil.debug('Iterating player data -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          } else if(snapshot.hasData && snapshot.data is PlayerData) {
            final pd = snapshot.data as PlayerData;
            LogUtil.debug('Iterating player data -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
            return _buildScrollableContent(pd,);                        
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
        return const Center(child: Text('Exception'),);
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
            ProfileSection(playerData: playerData),
            const SizedBox(height: 40),
            MenuSection(playerData: playerData,),
            const SizedBox(height: 40),
            //const SignInButton(isSignedIn: false),            
          ],
        ),
      ),
    );
  }
  
}