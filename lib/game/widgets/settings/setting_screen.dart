import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/game_option.dart';
import 'package:endless_runner/game/widgets/settings/widgets/profile_section.dart';
import 'package:endless_runner/game/widgets/settings/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () {
            
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: _buildPadding(),
    );
  }

  Padding _buildPadding() {
    LogUtil.debug('Start building Setting.');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          SizedBox(height: 20),
          GameOption(),
          SizedBox(height: 20),
          SignInButton(isSignedIn: false,),
        ],
      )
    );
  }
  
}