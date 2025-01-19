
import 'package:endless_runner/constants/game_constant.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';


class PlayerAppearanceSetting extends StatefulWidget {
  final String currentSkin;
  final Function(String) onAppearanceChanged;


  const PlayerAppearanceSetting({super.key, required this.currentSkin, 
    required this.onAppearanceChanged
  });

  @override
  State<PlayerAppearanceSetting> createState() => _PlayerAppearanceSettingState();
}

class _PlayerAppearanceSettingState extends State<PlayerAppearanceSetting> {
  late String _selectedSkin;

  @override
  void initState() {
    super.initState();
    _selectedSkin = widget.currentSkin;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Building player appearance setting');
    return _dropdownButton();
  }

  DropdownButton _dropdownButton() {
    LogUtil.debug('Building Player Appearance Setting, selected skin: $_selectedSkin');
    return DropdownButton<String>(
      value: _selectedSkin,
      onChanged: (String? newValue) {
        setState(() {
          _selectedSkin = newValue!;
          widget.onAppearanceChanged(_selectedSkin);
        });
      },
      items: <String>[GameConstant.playerSkinClassic, GameConstant.playerSkinModern, GameConstant.playerSkinFuturistic]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}