import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';

class GameOption extends StatelessWidget {
  const GameOption({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildColumn();
  }

  Column _buildColumn() {
    LogUtil.debug('Start building Setting - Game Option');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.restore),
          title: Text('Reset Game'),
          onTap: () {
            // Trigger game reset
          },
        ),
        ListTile(
          leading: Icon(Icons.music_note),
          title: Text('Background Music'),
          trailing: Switch(
            value: true,
            onChanged: (bool value) {
              // Toggle background music
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.volume_up),
          title: Text('Sound Effects'),
          trailing: Switch(
            value: true,
            onChanged: (bool value) {
              // Toggle sound effects
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('About Us'),
          onTap: () {
            // Trigger game reset
          },
        ),
      ],
    );
  }
  
}