import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/player_signedup_edit.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.playerData});
  
  final PlayerData playerData;

  @override
  Widget build(BuildContext context) {
    return _buildRow(context);
  }

  Row _buildRow(BuildContext context) {
    LogUtil.debug('Start building Setting - Profile Section');
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage( playerData.profileImgPath ?? 'assets/images/player_1.png'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerData.playerName,              
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Open dialog to edit player name/image
                showPlayerEditDialog(context, playerData);
              },
              child: const Text('Edit Profile',),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> showPlayerEditDialog(BuildContext context, PlayerData playerData) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlayerSignedupEdit(playerData: playerData);
      }
    );
  }
  
}