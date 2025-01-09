import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/player_signup.dart';
import 'package:flutter/material.dart';

class GameOption extends StatelessWidget {
  GameOption({super.key, required this.playerData});

  final PlayerData playerData;
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Inside build method');
    return _buildColumn(context);
  }

  Column _buildColumn(BuildContext context) {
    LogUtil.debug('Start building Setting - Game Option');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...  playerData.playerName == 'Unknown' ? _buildMenuLisSignUp(context) : _buildMenuListSignedUp(context),
      ],
    );
  }

  List<Widget> _buildMenuListSignedUp(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.restore, color: Colors.blue, size: 28),
        title: Text('Reset Game'),
        onTap: () {
          // Trigger game reset
        },
      ),
      ListTile(
        leading: Icon(Icons.music_note, color: Colors.blue, size: 28),
        title: Text('Background Music'),
        trailing: Switch(
          value: true,
          onChanged: (bool value) {
            // Toggle background music
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.volume_up, color: Colors.blue, size: 28),
        title: Text('Sound Effects'),
        trailing: Switch(
          value: true,
          onChanged: (bool value) {
            // Toggle sound effects
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.person, color: Colors.blue, size: 28),
        title: Text('About Us'),
        onTap: () {
          // Trigger game reset
        },
      ),
    ];
  }

  List<Widget> _buildMenuLisSignUp(BuildContext context) {
    return [      
        ListTile(
          leading: Icon(Icons.person_add, color: Colors.blue, size: 28),
          title: Text('Sign Up'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerSignup(playerAuthManager: _playerAuthManager),
              ),
            );
          },
        ),
      ListTile(
        leading: Icon(Icons.restore, color: Colors.blue, size: 28),
        title: Text('Reset Game'),
        onTap: () {
          // Trigger game reset
        },
      ),
      ListTile(
        leading: Icon(Icons.music_note, color: Colors.blue, size: 28),
        title: Text('Background Music'),
        trailing: Switch(
          value: true,
          onChanged: (bool value) {
            // Toggle background music
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.volume_up, color: Colors.blue, size: 28),
        title: Text('Sound Effects'),
        trailing: Switch(
          value: true,
          onChanged: (bool value) {
            // Toggle sound effects
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.person, color: Colors.blue, size: 28),
        title: Text('About Us'),
        onTap: () {
          // Trigger game reset
        },
      ),
    ];
  }
  
}