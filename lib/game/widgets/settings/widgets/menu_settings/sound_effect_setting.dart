
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/theme/endless_runner_theme.dart';
import 'package:flutter/material.dart';

class SoundEffectSetting extends StatefulWidget {
  const SoundEffectSetting({super.key, required this.currentSoundEffectSettings, required this.onSettingsChanged});

  final Map<String, dynamic> currentSoundEffectSettings;
  final Function(Map<String, dynamic>) onSettingsChanged;

  @override
  State<SoundEffectSetting> createState() => _SoundEffectSettingState();

}

class _SoundEffectSettingState extends State<SoundEffectSetting> {
  late Map<String, dynamic> _currentSoundEffectSettings;
  @override
  void initState() {
    super.initState();
    _currentSoundEffectSettings = widget.currentSoundEffectSettings; 
    _checkSoundEffectSettings();

  }

  void _checkSoundEffectSettings() {
    if (_currentSoundEffectSettings.isEmpty) {
      _currentSoundEffectSettings = {
        GameConstant.backgroundMusicKey: true,
        GameConstant.buttonClickSoundKey: true,
        GameConstant.gameOverSoundKey: true,
        GameConstant.disableAllSoundEffects: false,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sound Effect Setting', style: EndlessRunnerTheme.of(context).titleH2TextStyle,)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Background Music', style: EndlessRunnerTheme.of(context).normalTextStyle),
              value: _currentSoundEffectSettings[GameConstant.backgroundMusicKey],
              onChanged: (bool value) {
                setState(() {
                  _currentSoundEffectSettings[GameConstant.backgroundMusicKey] = value;
                });
                widget.onSettingsChanged(_currentSoundEffectSettings);
              },
            ),
            SwitchListTile(
              title: Text('Button Click Sound', style: EndlessRunnerTheme.of(context).normalTextStyle,),
              value: _currentSoundEffectSettings[GameConstant.buttonClickSoundKey],
              onChanged: (bool value) {
                setState(() {
                  _currentSoundEffectSettings [GameConstant.buttonClickSoundKey] = value;
                });
                widget.onSettingsChanged(_currentSoundEffectSettings);
              },
            ),
            SwitchListTile(
              title: Text('Game Over Sound', style: EndlessRunnerTheme.of(context).normalTextStyle,),
              value: _currentSoundEffectSettings[GameConstant.gameOverSoundKey],
              onChanged: (bool value) {
                setState(() {
                  _currentSoundEffectSettings [GameConstant.gameOverSoundKey] = value;
                });
                widget.onSettingsChanged(_currentSoundEffectSettings);
              },
            ),
            SwitchListTile(
              title: Text('Disable All Sound Effect', style: EndlessRunnerTheme.of(context).normalTextStyle,),
              value: _currentSoundEffectSettings[GameConstant.disableAllSoundEffects],
              onChanged: (bool value) {
                value ? _disableAllSoundEffects() : _enableAllSoundEffects();
              },
            ),

          ],
        ),
      ),
    );
  }

  void _disableAllSoundEffects() {
    setState(() {
      _currentSoundEffectSettings [GameConstant.gameOverSoundKey] = false;
      _currentSoundEffectSettings [GameConstant.buttonClickSoundKey] = false;
      _currentSoundEffectSettings [GameConstant.backgroundMusicKey] = false;
      _currentSoundEffectSettings [GameConstant.disableAllSoundEffects] = true;
    });
    widget.onSettingsChanged(_currentSoundEffectSettings);
  }

  void _enableAllSoundEffects() {
    setState(() {
      _currentSoundEffectSettings [GameConstant.gameOverSoundKey] = true;
      _currentSoundEffectSettings [GameConstant.buttonClickSoundKey] = true;
      _currentSoundEffectSettings [GameConstant.backgroundMusicKey] = true;
      _currentSoundEffectSettings [GameConstant.disableAllSoundEffects] = false;
    });
    widget.onSettingsChanged(_currentSoundEffectSettings);
  }

}