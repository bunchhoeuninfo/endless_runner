import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.playerData});
  //const ProfileSection({super.key});
  final PlayerData playerData;

  @override
  Widget build(BuildContext context) {
    return _buildRow();
  }

  Row _buildRow() {
    LogUtil.debug('Start building Setting - Profile Section');
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/player_1.png'),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerData.playerName,              
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Open dialog to edit player name/image
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ],
    );
  }
  
}