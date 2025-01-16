import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/data/sound_effect_option.dart';
import 'package:flutter/material.dart';

class SoundEffectSetting extends StatefulWidget {
  const SoundEffectSetting({super.key, required this.playerData,});

  final PlayerData playerData;

  @override
  State<SoundEffectSetting> createState() => _SoundEffectSettingState();

}

class _SoundEffectSettingState extends State<SoundEffectSetting> {
  late PlayerData _playerData;
  @override
  void initState() {
    super.initState();
    _playerData = widget.playerData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Background Music'),
              value: _playerData.settings.map(convert),
              onChanged: (bool value) {
                setState(() {
                  _soundEffectOption.backgroundMusic = value;
                });
                widget.onSettingsChanged(_soundEffectOption);
              },
            ),
            SwitchListTile(
              title: Text('Button Click Sound'),
              value: _soundEffectOption.buttonClickSound,
              onChanged: (bool value) {
                setState(() {
                  _soundEffectOption.buttonClickSound = value;
                });
                widget.onSettingsChanged(_soundEffectOption);
              },
            ),
            SwitchListTile(
              title: Text('Game Over Sound'),
              value: _soundEffectOption.gameOverSound,
              onChanged: (bool value) {
                setState(() {
                  _soundEffectOption.gameOverSound = value;
                });
                widget.onSettingsChanged(_soundEffectOption);
              },
            ),
          ],
        ),
      ),
    );
  }

}