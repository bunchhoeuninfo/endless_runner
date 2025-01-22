
import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/core/managers/game_state_manager.dart';
import 'package:endless_runner/core/managers/player_data_notifier_manager.dart';
import 'package:endless_runner/core/services/game_state_service.dart';
import 'package:endless_runner/core/services/live_score_service.dart';
import 'package:endless_runner/core/managers/game_service_manager.dart';
import 'package:endless_runner/core/services/game_service_service.dart';
import 'package:endless_runner/core/services/player_data_notifier_service.dart';
import 'package:endless_runner/core/state/game_state.dart';
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/setting_screen.dart';
import 'package:endless_runner/game/widgets/settings/widgets/signup/player_signup.dart';

import 'package:flutter/material.dart';

class StartSignupButtonOverlay extends StatelessWidget {
  final EndlessRunnerGame game;
  final GameServiceManager _gameServiceManager = GameServiceService();
  final LiveScoreService _liveScoreService = LiveScoreService();
  final GameStateManager _gameStateManager = GameStateService();
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();
  final PlayerDataNotifierManager _playerDataNotifierManager = PlayerDataNotifierService();
  
  StartSignupButtonOverlay({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _futureBuilder();
  }

  FutureBuilder _futureBuilder() {
    LogUtil.debug('Inside future builder');
    return FutureBuilder(
      future: _liveScoreService.loadGameProgress(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading progress'),);
        } else {
          LogUtil.debug('Inside future builder else');
          _gameStateManager.stateNotifier.value = GameState.menu;
          return _buildPlayerProgresInfo(context);
        }    
      }
    );
  }

  Center _buildPlayerProgresInfo(BuildContext context) {
    LogUtil.debug('Inside build player progress info method');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Player information at the top
          Column(
            children: [
              _buildRow(null, _liveScoreService.encouragementNotifier, Colors.amber),
              const SizedBox(height: 5),
              //_buildRow('Player', _liveScoreService.playerNameNotifier, Colors.yellow),
              //_buildItem('Top Score', _playerDataNotifierManager.playerDataNotifier.value.playerName, Colors.yellow),
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Player', playerData.playerName, Colors.blue);
                },
              ),
              const SizedBox(height: 5),
              //_buildRow('Top Score', _liveScoreService.highScoreNotifier, Colors.green),
              //_buildItem('Top Score', _playerDataNotifierManager.playerDataNotifier.value.topScore, Colors.yellow),
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Top Score', playerData.topScore, Colors.yellow);
                },
              ),
              const SizedBox(height: 5,),
              //_buildRow('Level', _liveScoreService.levelNotifier, Colors.blue),
              //_buildItem('Level', _playerDataNotifierManager.playerDataNotifier.value.level, Colors.green),
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  return _buildItem('Level', playerData.level, Colors.green);
                },
              ),

              const SizedBox(height: 20,),
            ],
          ),
          // Row for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              ElevatedButton(
                onPressed: () {
                  _gameServiceManager.startGame(game);   
                  _gameStateManager.stateNotifier.value = GameState.playing;                         
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),   
              const SizedBox(width: 20), 
              ValueListenableBuilder<PlayerData>(
                valueListenable: _playerDataNotifierManager.playerDataNotifier,
                builder: (context, playerData, child) {
                  //return _buildItem('Player', playerData.playerName, Colors.blue);
                  return playerData.playerName == GameConstant.playerUknown 
                    ? _buildSignupButton(context) : Container();
                },
              ),
              /*_liveScoreService.playerNameNotifier.value == GameConstant.playerUknown 
                ? _buildSignupButton(context) : Container(),   */        
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSignupButton(BuildContext context) {
    LogUtil.debug('Building sign up button');
    return ElevatedButton(
      onPressed: () {
        //_gameServiceManager.startGame(game);   
        _gameStateManager.stateNotifier.value = GameState.setting;       
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerSignup(playerAuthManager: _playerAuthManager),),
        );                          
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }



  Widget _buildRow<T>(String? label, ValueNotifier<T> notifier, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label != null ? '$label: ' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem<T>(String? label, dynamic value, Color valueColor) {
    LogUtil.debug('Inside _buildRow method');
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label != null ? '$label: ' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: valueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
  }

}