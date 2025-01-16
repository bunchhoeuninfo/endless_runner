import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/data/sound_effect_option.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/about_me/developer_profile_widget.dart';
import 'package:endless_runner/game/widgets/settings/widgets/signup/player_signup.dart';
import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  MenuSection({super.key, required this.playerData});

  final PlayerData playerData;
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Building menu seciton');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildMenuItems(context),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    LogUtil.debug('Building menu item');
    return playerData.playerName == 'Unknown'
        ? [_menuItem(
            context,
            icon: Icons.person_add,
            text: 'Sign Up',
            onTap: () => _navigateTo(
              context,
              PlayerSignup(playerAuthManager: _playerAuthManager),
            ),
          )]
        : [
            _menuItem(
              context,
              icon: Icons.restore,
              text: 'Reset Game',
              onTap: () => LogUtil.debug('Reset Game Tapped'),
            ),
            _menuItem(
              context,
              icon: Icons.music_note,
              text: 'Player Skin',
              trailing: _switchWidget(
                value: true,
                onChanged: (value) => LogUtil.debug('Background Music: $value'),
              ),
            ),
            _menuItem(
              context,
              icon: Icons.volume_up,
              text: 'Sound Effects',
              trailing: const Icon(Icons.chevron_right, color: Colors.blue,),
              onTap: () => _navigateTo(
                context,
                SoundEffectOption(),
              ),
            ),
            _menuItem(
              context,
              icon: Icons.games_sharp,
              text: 'Game Themse',
              trailing: _switchWidget(
                value: true,
                onChanged: (value) => LogUtil.debug('Sound Effects: $value'),
              ),
            ),
            _menuItem(
              context,
              icon: Icons.person,
              text: 'About Me',
              onTap: () => _navigateTo(context, DeveloperProfileWidget()),
            ),
          ];
  }


  Widget _menuItem(BuildContext context,
      {required IconData icon,
      required String text,
      Widget? trailing,
      VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 28),
      title: Text(text),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _switchWidget({required bool value, required ValueChanged<bool> onChanged}) {
    return Switch(value: value, onChanged: onChanged);
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
  
}